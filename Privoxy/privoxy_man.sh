0. 预备知识
    # 为什么终端代理需要安装 privoxy
    因为 shadowsocks 是使用 socks5 协议进行代理的，终端很多协议不是 socks5，比如 http、https、ftp等
    所以需要安装 privoxy 软件，将这些协议转换成 sockes5 协议后，才能使用 shadowsocks 进行代理，
    而浏览器不需要安装其他软件，是因为它自带转换功能

1. ubuntu_18.04.1 下安装 privoxy
    shell> apt-get install privoxy

2. 配置
    shell> vim /etc/privoxy/config
    找到 4.1. listen-address 这一节，确认监听的端口号。
    
    找到 5.2. forward-socks4, forward-socks4a, forward-socks5 and forward-socks5t 
    添加一行 注意最后的 . 号：
    forward-socks5 / 127.0.0.1:1080 .
    
3. 重启 privoxy
    shell> /etc/init.d/privoxy restart

4. 配置终端代理
    shell> export http_proxy="127.0.0.1:8118"
    shell> export https_proxy="127.0.0.1:8118"
    
5. 永久配置终端代理
    shell> vim /etc/environment         # 编辑系统环境变量配置文件
    添加一下两行，并保存
    export http_proxy="127.0.0.1:8118"          # 使用 privoxy 的端口，将 http 协议转换成 socks 协议，并转发到 1080 shadowsocks 的端口进行代理
    export https_proxy="127.0.0.1:8118"
    export ftp_proxy="127.0.0.1:8118"
    export socks_proxy="127.0.0.1:1080"         # 直接使用 shadowsocks 的端口，因为 shadowsocks 本来就是使用 socks 协议的
    
    shell> source /etc/environment      # 使配置生效