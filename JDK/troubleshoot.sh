################################ Concept & Basis ################################
CPU 爆高原因:
    代码中存在死循环
    JVM 频繁 GC
    加密和解密的逻辑
    正则表达式的处理
    频繁地线程上下文切换，即：线程频繁地挂起和唤醒需要消耗 CPU, 而且代价颇大
        因为线程上下文切换是 系统在进行线程上下文切换时消耗的 CPU 资源，而 线程本身 并不消耗 CPU 资源
        所以该情形表现符合以下特点:
            1. JVM 层面使用 CPU 爆满
            2. Thread 层面又基本不消耗 CPU 资源

    注意:
        死锁不会引起 CPU 爆高
        线程 WAITING, BLOCKED 状态是不会消耗 CPU 资源的

Native Thread Status: 系统原生线程状态
    deadlock: 死锁，一般指多个线程调用期间进入了相互资源占用，导致一直等待无法释放的情况。
    runnable: 正在执行, 该线程占用了资源，正在处理某个操作，如通过SQL语句查询数据库、对某个文件进行写入等
    blocked: 阻塞状态，指当前线程执行过程中，所需要的资源长时间等待却一直未能获取到，被容器的线程管理器标识为阻塞状态，可以理解为等待资源超时的线程
    waiting on condition: 线程正处于等待资源或等待某个条件的发生，具体的原因需要结合下面堆栈信息进行分析
        （1）如果堆栈信息明确是应用代码，则证明该线程正在等待资源，一般是大量读取某种资源且该资源采用了资源锁的情况下，线程进入等待状态，等待资源的读取，或者正在等待其他线程的执行等。
        （2）如果发现有大量的线程都正处于这种状态，并且堆栈信息中得知正等待网络读写，这是因为网络阻塞导致线程无法执行，很有可能是一个网络瓶颈的征兆：
            网络非常繁忙，几乎消耗了所有的带宽，仍然有大量数据等待网络读写；
            网络可能是空闲的，但由于路由或防火墙等原因，导致包无法正常到达；
            所以一定要结合系统的一些性能观察工具进行综合分析，
            比如 netstat 统计单位时间的发送包的数量，看是否很明显超过了所在网络带宽的限制；
            观察CPU的利用率，看系统态的CPU时间是否明显大于用户态的CPU时间。这些都指向由于网络带宽所限导致的网络瓶颈。
        （3）还有一种常见的情况是该线程在 sleep，等待 sleep 的时间到了，将被唤醒。
    waiting for monitor entry :
        Moniter 是Java中用以实现线程之间的互斥与协作的主要手段，它可以看成是对象或者class的锁，每个对象都有，也仅有一个 Monitor。
        synchronized(obj) { ... }
    in Object.wait():
         等待 obj.notify() 或 obj.notifyAll() 方法执行的 线程

JVM Thread Status：JVM 线程运行状态
    NEW: 
        至今尚未启动的线程的状态。
        线程刚被创建，但尚未启动
    RUNNABLE: 
        可运行线程的线程状态。
        线程正在JVM中执行，有可能在等待操作系统中的其他资源，比如处理器
    BLOCKED: 
        受阻塞并且正在等待监视器的某一线程的线程状态。
        处于受阻塞状态的某一线程正在等待 Monitor 锁，以便进入一个同步的块/方法，或者在调用 Object.wait 之后再次进入同步的块/方法
        在Thread Dump日志中通常显示为 java.lang.Thread.State: BLOCKED (on object monitor)
    WAITING:
        某一等待线程的线程状态。
        线程正在无期限地等待另一个线程来执行某一个特定的操作，线程因为调用下面的方法之一而处于等待状态：
            不带超时的 Object.wait 方法，日志中显示为 java.lang.Thread.State: WAITING (on object monitor)
            不带超时的 Thread.join 方法，LockSupport.park 方法，日志中显示为 java.lang.Thread.State: WAITING (parking)
    TIMED_WAITING:
        指定了等待时间的某一等待线程的线程状态。
        线程正在等待另一个线程来执行某一个特定的操作，并设定了指定等待的时间，线程因为调用下面的方法之一而处于定时等待状态：
            Thread.sleep 方法
            指定超时值的 Object.wait 方法
            指定超时值的 Thread.join 方法
            LockSupport.parkNanos
            LockSupport.parkUntil
    TERMINATED:
        线程处于终止状态。


################################ 坑 ################################
cap_add: [SYS_PTRACE]               # docker 部署，如果不加这个配置，jstack, jmap 等工具无法使用
-XX:+DisableAttachMechanism         # 如果启动参数包含这个，jstack, jmap 等工具无法使用
/tmp/hsperfdata_$USER               # jstack 和  jmap 默认从该文件读取 jvm 进程信息，
                                    # 由于 Tomcat 一般会指定 -Djava.io.tmpdir=${tomcat_home}/tmp/ 参数，来修改临时目录，会导致 jps, jstack 报错


################################ Troubleshoot Procedure ################################
######## PID: 获取当前有问题的 jvm(java) 进程 ID，即: shell> java ... ; 生成的 PID
shell> jps -l                       # 适合 java 进程少的情况
shell> ps -ef | grep java           # 信息更详尽
shell> lsof -i:<port>               # 适合有多个 java 进程，根据 jps 可能分辨不出来想找的进程，而需要通过端口号进行定位
shell> top                          # 找到有问题的 java 进程的 PID


######## 导出 jvm 的线程栈，
# 巨神坑: jstack 只能导出整个 jvm 的线程栈，所以指定的 PID 必须是 jvm(java) 的 PID，而不能是 TID(线程id)
shell> jstack -l PID > zzz.jstack                           # 将指定 java PID 的堆栈信息导出到 zzz.jstack 文件中, zzz 是因为 ll 就是最后，比较好找


######## TID: 获取占用高的 线程 ID，最好开两个 ssh ，跟上一步同时执行
shell> top -H -p PID                                        # 找到有问题的 线程，得到 TID
shell> printf "0x%x\n" TID                                  # 将 10进制的 线程 TID 转换为 16进制的 0xTID，为后面查找 jstack 日志做准备


######## Analyze: 分析
shell> grep -A 30 nid=0xTID zzz.jstack                      # 搜索
shell> vim +/0xTID                                          # 查看 线程是否有问题

#### 是否死锁判断
shell> grep -C 30 'parking to wait for  <0x000000070a349638>' zzz.jstack        # 表示当前线程正在等待名为 <0x000000070a349638> 的资源
shell> grep -C 30 'locked <0x000000070a349638>' zzz.jstack                      # 表示当前线程锁定了名为 <0x000000070a349638> 的资源
shell> # 如果一个线程，既锁定了一个资源，又等待另一个资源，而另一个资源又被其他线程锁定，造成相互等待的局面，就形成了 死锁




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
# 巨神坑: pid 是 java 进程的 PID，而不是 CPU 爆高的线程的 TID，虽然 TID 在 linux 也叫做 PID，但是两者不一样
shell> jstack   -F <pid>        # 强制 dump 堆栈信息，在 java 进程 hung(挂) 起时使用
                -m              # 打印 java 和 native（C++） 堆栈信息 
                -l              # 打印额外的信息，包括锁信息
                
shell> jstack -l <pid>          # 常用，一般不带 -F，因为导致 CPU 爆满的 java 进程(PID)，肯定有线程是 RUNNABLE 状态

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
     











