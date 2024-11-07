# 查看 所有可以使用的 shell> java -Dxxx  中的 xxx
shell> # 下载 jdk 源码，src.zip 并解压
shell> grep --color -A4 -inr 'System.getProperty(' jdkSrcDir        # 可以看到所有用到的参数，-A4 是为了防止 System.getProperty( 之后直接换行导致查找结果不全
shell> grep --color -A4 -inr 'System.getProperty(' | grep --color -in 'javax.net.ssl.'    # 对查找结果进一步搜索指定的 System Property

# 给 Java 配置 CA Root 证书
shell> cd $JAVA_HOME/jre/lib/security/cacerts
shell> sudo keytool -import -alias charles -file ~/Desktop/charles-ssl-proxying-certificate.pem -keystore $JAVA_HOME/jre/lib/security/cacerts -storepass changeit
shell> keytool -list -keystore $JAVA_HOME/jre/lib/security/cacerts -storepass changeit

# 运行一个 java 程序
    shell> cd $JAVA_HOME/bin
    shell> ./java -jar myapp.jar        # 启动一个 jvm 实例，运行一个 ./myapp.jar 文件
    shell> java -jar .\procyon-decompiler.jar %%a -o .\source # 运行一个 jar 包，后面的是该 jar 包运行传入的参数
    shell> ./java kasei.HelloWorld      # 启动一个 jvm 实例，运行一个 ./kasei/HelloWorld.class 文件
    

# java classpath 配置格式
    1. 对于 命名包中的 .class 文件，
       例如： .class 文件路径为： /home/kasei/com/apache/common/StringUtils.class 
             StringUtils 类的包路径为：com.apache.common     即： package com.apache.common;
             则 classpath 应配置为： classpath=/home/kasei
    2. 对于 未命名包中的 .class 文件
       例如： .class 文件的路径为： /opt/repo/Hello.class
             Hello 类的包路径为： 空            即: package ; 没有定义
             则 classpath 应配置为： classpath=/opt/repo
    3. 对于包含 .class 文件的 .jar 或 .zip 文件，
       例如： jar 包位置为： /opt/repo/source/xxx.jar
             则 classpath 应配置为： classpath=/opt/repo/source/xxx.jar
    4. 通配符： 只支持 *
       
       例如：  
            classpath=/home/dir         # 表示加载所有该 目录 下的 .class 文件(包括 命名包 和 未命名包)，但是不会加载 .jar 文件
            
            @trap 以下两种方式很多 jdk 不支持，需要自行测试
            classpath=/home/dir/*       # 表示加载所有 /home/dir 目录了下的 .jar 文件，注意：不会递归加载 子目录 中的 .jar 文件，
            classpath=/home/dir/        # 同上
                


# jvm 启动参数分类
#   https://docs.oracle.com/en/java/javase/21/index.html                         # -> Tools -> JDK Tool Specifications
#   https://docs.oracle.com/en/java/javase/21/docs/specs/man/index.html          # 进入 java 命令页面
#   https://docs.oracle.com/en/java/javase/21/docs/specs/man/java.html           # 点击 "Advanced Runtime Options for Java" 链接
#   1. 标准参数（-），所有的JVM实现都必须实现这些参数的功能，而且向后兼容；
#   2. 非标准参数（-X），默认jvm实现这些参数的功能，但是并不保证所有jvm实现都满足，且不保证向后兼容；
#   3. 非Stable参数（-XX），此类参数各个jvm实现会有所不同，将来可能会随时取消，需要慎重使用；
# 查看 jvm 启动参数 
    # -XX:+PrintFlagsInitial 输出格式
    #   第一列表示参数的数据类型，第二列是名称，第四列为值，第五列是参数的类别。
    #   第三列 "=" 表示第四列是参数的默认值，而 ":=" 表明了参数被用户或者JVM赋值了
    shell> ./java -XX:+PrintFlagsInitial >> AllBootParam.txt    # 输出所有 -XX 参数和值，初始值
    shell> ./java -XX:+PrintFlagsFinal                          # 输出所有 -XX 参数和值，最终值
    shell> ./java -XX:+PrintCommandLineFlags                    # 让 JVM 打印出那些已经被用户 或者 JVM 设置过的详细的 -XX 参数的名称和值
    shell> ./java -classpath    # java 命令默认会根据 CLASSPATH 环境变量 中的路径寻找 .class 文件， CLASSPATH=.:%JAVA_HOME%/lib
                                # -classpath 告诉 jvm 运行时所有文件的加载路径，设置该参数后将使 CLASSPATH 环境变量失效，
                                # 如果 CLASSPATH 和 -classpath 都不存在，jvm 默认使用当前目录(./)作为类搜索路径
    shell> ./java -javaagent:/root/agent.jar  # 加载 java 变成语言代理
    
    # Debug 方式启动 jvm 
    # Debug 模式：Attach to remote JVM (即: server=y) : jvm 监听一个 debug 端口，等待 client 连接
    # suspend=n     表示如果没有 debug client 连接，jvm 不会挂起，而是会执行代码
    # suspend=y     表示如果没有 debug client 连接，jvm 会挂起，确保 client 连接后，再运行代码
    shell> java -jar myapp.jar -Dagentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5505      # jdk 8
    shell> java -jar myapp.jar -Dagentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5505    # jdk 9+ 
    # Debug 模式：Listen to remote JVM (即: server=n) : jvm 向指定主机的指定端口发送 dubug 信息，client 监听本地对应的端口，
    shell> java -jar myapp.jar -agentlib:jdwp=transport=dt_socket,server=n,address=Haku:5005,suspend=y,onthrow=<FQ exception class name>,onuncaught=<y/n>


    # JVM 参数调优
    #   @doc https://blog.csdn.net/qq_44866828/article/details/126309447
    #   目标:
    #       堆内存使用率<=70%;
    #       老年代内存使用率<=70%;
    #       avgpause <= 1s;
    #       Full GC 次数 约等于 0 或 avg pause interval >= 24 小时 ;
    #   调优顺序: 优先级不可变
    #       满足程序的内存使用需求
    #       满足时间延迟的要求
    #       满足吞吐量的要求
    shell> java 
            # 吞吐量 调优: 运行用户代码的时间占总运行时间的行例 （总运行时间=程序的运行时间+内存回收的时间）
            # GC 调优: 
            -XX:+HeapDumpOnOutOfMemoryError             # 出现OOME时生成堆dump 或者在 OOM 前使用 jmap 命令导出，推荐使用当前方式
            -XX:HeapDumpPath=/home/hadoop/dump/         # 生成堆文件地址：
            -XX:+UseZGC                                 # 使用 ZGC
            -XX:+DisableExplicitGC          # 禁止运行期显式地调用System.gc()来触发fulll GC
            
            # GC 日志相关
            -XX:+PrintGC                    # 输出简要GC日志
            -XX:+PrintGCDetails             # 输出详细GC日志
            -Xloggc:gc.log                  # 输出GC日志到文件
            -XX:+PrintGCTimeStamps          # 输出GC的时间戳（以JVM启动到当期的总时长的时间戳形式）
            -XX:+PrintGCDateStamps          # 输出GC的时间戳（以日期的形式，如 2020-04-26T21:53:59.234+0800）
            -XX:+PrintHeapAtGC              # 在进行GC的前后打印出堆的信息
            -verbose:gc                     # 在JDK 8中，-verbose:gc是-XX:+PrintGC一个别称，日志格式等价于：-XX:+PrintGC。不过在JDK 9中 -XX:+PrintGC被标记为deprecated。 -verbose:gc是一个标准的选项，-XX:+PrintGC是一个实验的选项，建议使用-verbose:gc 替代-XX:+PrintGC
            -XX:+PrintReferenceGC           # 打印年轻代各个引用的数量以及时长
            
            # 内存 调优：
            -Xms2G              # 堆 初始值 或 最小值，通常设置为 -Xmx 的值，避免运行时要不断扩展JVM内存，等价于 -XX:InitialHeapSize
            -Xmx16G             # 堆 最大值，建议扩大至3-4倍FullGC后的老年代空间占用，等价于 -XX:MaxHeapSize 推荐：1/2 物理内存
            -Xmn1g              # 新生代内存的大小，包括Eden区和两个Survivor区的总和， 1-1.5倍FullGC之后的老年代空间占用 或者 1/3 -Xmx
                                # 避免新生代设置过小，当新生代设置过小时，会带来两个问题：一是minor GC次数频繁，二是可能导致 minor GC对象直接进老年代。当老年代内存不足时，会触发Full GC。 
                                # 避免新生代设置过大，当新生代设置过大时，会带来两个问题：一是老年代变小，可能导致Full GC频繁执行；二是 minor GC 执行回收的时间大幅度增加
            -XX:MetaspaceSize=256m          # 同 jdk7 -XX:PermSize 永久代
            -XX:MaxMetaspaceSize=256m       # 同 jdk7 -XX:MaxPermSize 永久代，建议扩大至1.2-1.5倍FullGc后的永久带空间占用
            -Xss1m                          # 每个线程的栈内存，默认1M，般来说是不需要改的
            -XX:NewRatio=4                  # 设置年轻代（包括Eden和两个Survivor区）与老年代的比值（除去持久代）。设置为4，则年轻代与老年代所占比值为1：4，年轻代占整个堆栈的1/5
            -XX:SurvivorRatio=8             # 设置年轻代中Eden区与Survivor区的大小比值。设置为8，则两个Survivor区与个Eden区的比值为2:8，每个Survivor区占整个年轻代的1/10
            -XX:MaxDirectMemorySize=1G      # 直接内存。报java.lang.OutOfMemoryError: Direct buffermemory异常可以上调这个值
            -XX:InitialCodeCacheSize        # JIT 编译期的 代码缓存，如果满了，字节码将不再会被编译成机器码
            -XX:+UseCodeCacheFlushing       # 当代码缓存被填满时让JVM放弃一些编译代码
            
    # JVM 常用启动参数
    shell> java -Djava.net.preferIPv4Stack=true     # 优先使用 IPv4
    shell> java -Dhttp.proxyHost=127.0.0.1 -Dhttp.proxyPort=8888    # java Http Proxy 配置


# 查看 .class 文件的字节码信息
    shell> javap -l -c HelloWorld.class     # -l 打印行号，-c 反汇编， -v 详细， --help 帮助

# 查看已经运行的 jvm 信息
    shell> jcmd pid VM.flags   
    shell> jinfo -flags pid  
    shell> jmap -heap pid



jdk 自带的文件编码转换工具 {
    shell> native2ascii -encoding GBK file1 file2 # 将 GBK 编码的 file1 转成 unicode 编码的 file2，如果省略 GBK 那么表示 file1 是操作系统默认的编码格式
    shell> native2ascii -reverse -encoding utf8 file1 file2 # 将 unicode 编码的文件（file1）转成 utf-8 编码的文件 （file2），如果省略 UTF8 那么转成操作系统默认的编码格式
}


手工批量编译 {
    Linux {
        shell> find -name "*.java" > sources.txt
        shell> javac -d ./out @sources.txt
    }
    
    Windows {
        shell> dir /s /B *.java > sources.txt
        shell> javac -d .\out @sources.txt
    }
}


# jar 解压 压缩文件
    shell> jar -xvf xxx.jar                                 # 解压
    shell> jar -cvf0M new.jar BOOT-INF/ META-INF/ org/      # SpringBoot jar 重新打包


################################ bin 下工具 ################################
# https://docs.oracle.com/en/java/javase/21/docs/specs/man/index.html
jar                     jar文件管理工具，主要用于打包压缩、解压jar文件
jarsigner               jar密匙签名工具          
java                    Java运行工具，用于运行.class字节码文件或.jar文件
javac                   Java编译工具(Java Compiler)，用于编译Java源代码文件
javadoc                 Java文档工具，主要用于根据Java源代码中的注释信息生成HTML格式的API帮助文档
javap                   Java反编译工具，主要用于根据Java字节码文件反汇编为Java源代码文件
jcmd                    Java 命令行(Java Command)，用于向正在运行的JVM发送诊断命令请求
jconsole                图形化用户界面的监测工具，主要用于监测并显示运行于Java平台上的应用程序的性能和资源占用等信息
jdb                     Java调试工具(Java Debugger)，主要用于对Java应用进行断点调试
jdeprscan
jdeps
jfr
jhsdb
jimage
jinfo                   Java配置信息工具(Java Configuration Information)，用于打印指定Java进程、核心文件或远程调试服务器的配置信息
jlink
jmap                    Java内存映射工具(Java Memory Map)，主要用于打印指定Java进程、核心文件或远程调试服务器的共享对象内存映射或堆内存细节
jmod
jpackage
jps                     JVM进程状态工具(JVM Process Status Tool)，用于显示目标系统上的HotSpot JVM的Java进程信息
jrunscript              Java命令行脚本外壳工具(command line script shell)，主要用于解释执行javascript、groovy、ruby等脚本语言
jshell
jstack                  Java堆栈跟踪工具，主要用于打印指定Java进程、核心文件或远程调试服务器的Java线程的堆栈跟踪信息
jstat                   JVM统计监测工具(JVM Statistics Monitoring Tool)，主要用于监测并显示JVM的性能统计信息
jstatd                  jstatd(VM jstatd Daemon)工具是一个RMI服务器应用，用于监测HotSpot JVM的创建和终止，并提供一个接口，允许远程监测工具附加到运行于本地主机的JVM上
keytool                 密钥和证书管理工具，主要用于密钥和证书的创建、修改、删除等。
rmiregistry             Java 远程对象注册表，用于在当前主机的指定端口上创建并启动一个远程对象注册表
serialver               序列版本命令，用于生成并返回serialVersionUID




