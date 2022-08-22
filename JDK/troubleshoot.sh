################################ 坑 ################################
cap_add: [SYS_PTRACE]               # docker 部署，如果不加这个配置，jstack, jmap 等工具无法使用
-XX:+DisableAttachMechanism         # 如果启动参数包含这个，jstack, jmap 等工具无法使用
/tmp/hsperfdata_$USER               # jstack 和  jmap 默认从该文件读取 jvm 进程信息，
                                    # 由于 Tomcat 一般会指定 -Djava.io.tmpdir=${tomcat_home}/tmp/ 参数，来修改临时目录，会导致 jps, jstack 报错


################################ Troubleshoot Procedure ################################
shell> top                                                  # 找到有问题的 java 进程的 PID
shell> top -p PID -H                                        # 找到有问题的 线程 PID2
shell> jstack -l PID2 > pid2.jstack                         # 将指定 PID2 的堆栈信息导出到 PID2.jstack 文件中
shell> printf "0x%x\n" PID2                                 # 将 10进制的 线程 PID2 转换为 16进制的 0xPID，为后面查找 jstack 日志做准备
shell> grep -A 30 nid=0xPID pid2.jstack                     # 搜索
shell> vim +/0xPID                                          # 查看 线程是否有问题




################################ Troubleshoot, Analyse, Monitor, Manager 工具 ################################
# @help https://docs.oracle.com/javase/8/docs/technotes/tools/
# @help https://xie.infoq.cn/article/32aa492c284f59a0014b69c52


################  Monitor
# JVM 进程状态工具 (JVM Process Status Tool)
# 在目标系统上列出 HotSpot Java 虚拟机进程的描述信息
shell> jps  -p          # 仅显示 JVM 标识
            -m          # 输出 main 函数的入参
            -l          # 输出 main 函数所在类的详细信息
            -v          # 列出 jvm 参数
            -V          # 列出 jvm 扩展参数

# JVM 统计监控工具 (JVM Statistics Monitoring Tool)
# 根据参数指定的方式收集和记录指定的 jvm 进程的性能统计信息。
shell> jstat -<option> -t -h 4 <lvmid>[@<hostname>[:<port>]] 100ms 32   # -t    在输出信息前加上一个Timestamp列，显示程序的运行时间    
                                                                        # -h 4      header line 之间有 4 个样本    
                                                                        # 100ms     采样间隔
                                                                        # 32        采样次数
                                                                                
# JVM jstat 守护程序
# 启动一个 RMI 服务器应用程序，用于监视测试的 HotSpot Java 虚拟机的创建和终止，并提供一个界面，允许远程监控工具附加到在本地系统上运行的 Java 虚拟机
shell> jstatd           

################  Troubleshoot
# Java 的配置信息工具 (Java Configuration Information)
# 用于打印指定 Java 进程、核心文件或远程调试服务器的配置信息
shell> jinfo <pid>

# Java 堆分析工具 (Java Heap Analysis Tool)
# 用于分析 Java 堆内存中的对象信息
# 用于分析heapdump文件，它会建立一个HTTP/HTML服务器，让用户可以在浏览器上查看分析结果，可以查找诸如内存方面的问题
# 是用来分析Java堆的命令，可以将堆中的对象以html的形式显示出来，包括对象的数量，大小等等，并支持对象查询语言
shell> jhat     


# Java 内存映射工具 (Java Memory Map)
# 主要用于打印指定 Java 进程、核心文件或远程调试服务器的共享对象内存映射或堆内存细节
shell> jmap [option] <pid>
            -heap               # 打印 java heap summary
            -histo[:live]       # 打印 java object heap 直方图，live 存在则只计算 live objects
            -clstats            # print class loader statistics
            -finalizerinfo      # 打印等待 finalize 的对象的信息
            -dump:live,format=b,file=heap.bin       # 只 dump live 的 object，二进制格式，导出到 heap.bin 文件中
            -F                  # 当 dump 和 histogram 没反应的时候
    
# 适用于 Java 的可维护性代理调试守护程序 (Java Serviceability Agent Debug Daemon)
# 主要用于附加到指定的 Java 进程、核心文件，或充当一个调试服务器。
shell> jsadebugd       

# Java 的堆栈跟踪工具，
# 主要用于打印指定 Java 进程、核心文件或远程调试服务器的 Java 线程的堆栈跟踪信息。
shell> jstack   -F <pid>        # 强制 dump 堆栈信息，在 线程 hung(挂) 起时使用
                -m              # 打印java 和 native（C++） 堆栈信息 
                -l              # 打印额外的信息，包括锁信息
                
shell> jstack -l <pid>          # 常用，一般不带 -F，因为导致 CPU 爆满的线程肯定是 RUNNABLE 状态

# JVM 诊断命令工具，将诊断命令请求发送到正在运行的 Java 虚拟机。
shell> jcmd -l                      # 列出本机上的 jvm 进程
shell> jcmd pid help                # 查看可以使用哪些 command，当 pid 为 0 时，表示向所有 java 进程发送 command
shell> jcmd PerfCounter.print       # 显示当前 jvm 进程暴露出来的 性能计数器

# # GUI 分析工具
shell> jconsole         

 

################################ 其他工具 ################################


shell> java             # 运行 .class 文件
shell> javac            # 编译 .java 文件
shell> javap            # 反编译工具

shell> jdb              # Java Debugger: 用于实时调试。一般开发中 IDE 已经封装好了，只有在远程服务器维护，没有 IDE 可以调试时，jdb 可以帮上忙
shell> jdeps            # Jave Dependencies: 显示 Java 类文件的包级或类级依赖关系
     











