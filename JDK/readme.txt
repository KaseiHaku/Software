JDK9 Modular 目录结构:
    shell> cd ~
    shell> mkdir jdk9/src && cd jdk9/src
    shell> mkdir kasei.jdk9.modular && cd kasei.jdk9.modular
    shell> mkdir kasei/jdk9/modular && cd kasei/jdk9/modular
    shell> touch Jdk9HelloWorld.java 
    # 编译
    shell> cd ~/jdk9
    shell> mkdir ./mods/kasei.jdk9.modular 
    shell> javac -d ./mods/kasei.jdk9.modular ./src/kasei.jdk9.modular/module-info.java ./src/kasei.jdk9.modular/kasei/jdk9/modular/Jdk9HelloWorld.java 
    # 执行
    shell> java --module-path ./mods -m kasei.jdk9.modular/kasei.jdk9.modular.Jdk9HelloWorld
    
Character Set 字符集:
    1. jvm 内部统一使用 Unicode 方式对 字符进行编码
    2. jvm 跟操作系统交互（即: 从 OS 读取 和 写出到 OS）时，如果 -Dfile.encoding=UTF-8 启动参数不存在，那么 jvm 会使用 系统默认字符集 来跟 OS 交互

Java Serializable 接口序列化后字节格式:
    Java 对象/实例 序列化后 前3个字节的码值为: ACED00
    
    
    
    
    
