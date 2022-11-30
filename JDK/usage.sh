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
#   https://docs.oracle.com/en/java/javase/17/docs/specs/man/java.html#advanced-runtime-options-for-java
#   1. 标准参数（-），所有的JVM实现都必须实现这些参数的功能，而且向后兼容；
#   2. 非标准参数（-X），默认jvm实现这些参数的功能，但是并不保证所有jvm实现都满足，且不保证向后兼容；
#   3. 非Stable参数（-XX），此类参数各个jvm实现会有所不同，将来可能会随时取消，需要慎重使用；
# 查看 jvm 启动参数 
    shell> ./java -XX:+PrintFlagsInitial >> AllBootParam.txt   # 查看所有 jvm 启动参数
    shell> ./java -XX:+PrintCommandLineFlags                    # 查看 jvm 启动时，所有 显示的 和 隐式的 参数
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






