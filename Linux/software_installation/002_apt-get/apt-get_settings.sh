1. 预备知识
    # 仓库配置文件位置及作用
    apt 包管理工具仓库配置文件如下：
    /etc/apt/sources.list                       # 该文件就是一个仓库文件
    /etc/apt/sources.list.d/                    # 该目录下保存各个独立的仓库配置文件，所有仓库的配置文件都是 .list 结尾的 

    # 仓库配置文件格式
    deb http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe mutiverse
    deb-src http://mirrors.aliyun.com/ubuntu/ bionic main restricted universe mutiverse
    deb 表示是编译好的仓库
    deb-src 表示是源代码仓库
    url 表示仓库的地址
    saucy
    main
    restricted
    
    
2. 备份自带的 apt 源
    shell> cd /etc/apt
    shell> cp sources.list ./sources.list.bak   

3. Adding Repository 添加软件源仓库
    # 编辑配置文件方式
    shell> cd /etc/apt/sources.list.d
    shell> touch aliyun.list                    # 新建一个文件，表示是 阿里云 的镜像源
    shell> touch google.list                    # 新建一个文件，表示是 google 的镜像源
    shell> vim aliyun.list
    添加如下行
    
    # 安装源
    deb https://mirrors.aliyun.com/debian/ bookworm main non-free-firmware
    deb-src https://mirrors.aliyun.com/debian/ bookworm main non-free-firmware
    # 安全更新源
    deb https://mirrors.aliyun.com/debian-security/ bookworm-security main non-free-firmware
    deb-src https://mirrors.aliyun.com/debian-security/ bookworm-security main non-free-firmware
    # 更新安装源
    # bookworm-updates, to get updates before a point release is made;
    # see https://www.debian.org/doc/manuals/debian-reference/ch02.en.html#_updates_and_backports
    deb https://mirrors.aliyun.com/debian/ bookworm-updates main non-free-firmware
    deb-src https://mirrors.aliyun.com/debian/ bookworm-updates main non-free-firmware

    保存
    

    # 命令行方式
    shell> add-apt-repository "deb http://us.archive.ubuntu.com/ubuntu/ saucy universe multiverse"


5. 安装密钥
    如果你添加了一个非 ubuntu 的软件仓库，你会被提示安装密钥，比如 google 的软件仓库
    shell> wget https://dl.google.com/linux/linux_signing_key.pub       # 下载密钥，默认保存到当前工作目录
    shell> apt-key add linux_signing_key.pub        # 安装密钥
    
4. 使新配置的源生效
    shell> apt-get update
    
    
5. 配置 apt 代理
    shell> man apt.conf         # 查看 apt 配置文件帮助
    /etc/apt/apt.conf           # apt 配置文件
    /etc/apt/apt.conf.d         # apt 片段配置文件保存目录，其中的配置片段在运行时会整合到 /etc/apt.conf 中去，相当于 C 语言的 include
    
    

    shell> cd /etc/apt/apt.conf.d           # apt fragment configuration directory 片段配置文件目录
    shell> touch 80proxy        # 新建一个配置文件片段
    添加一下行
    Acquire::http::Proxy "http://username:password@proxyhost:port/";
    Acquire::https::Proxy "https://username:password@proxyhost:port/";
    Acquire::ftp::Proxy "ftp://username:password@proxyhost:port/";
    
