shadowsocks 安装配置手册
################################ 预备知识
1. Shadowsocks 是采用 SOCKES（SOCKS5、SOCK4） 协议进行代理的，它只接受 SOCKS5 协议的流量，不接受 HTTP 或者 HTTPS 的流量。

2. 不同协议之间不能相互代理，如果需要采用不同协议的代理，需要使用软件进行转换，比如 Proxy SwitchyOmega（Chrome 插件）、Privoxy（终端协议转换软件）

3. Chrome 浏览器采用的是 HTTP 和 HTTPS 协议，如果想使用 SOCKS 协议进行代理，需要安装  Proxy SwitchyOmega插件，进行桥接转换，搞版本浏览器自带转换功能

4. Terminal 终端是没有自带的转换协议的，所以没法直接使用 Shadowsock 进行代理。这时候就需要一个协议转换器，这里我用了 Privoxy 。

################################ ubuntu-18.04.1 服务器端
1. 安装 shadowsocks
    shell> apt-get install shadowsocks-libev  
      
2. shadowsocks 配置
    shell> cd /etc/shadowsocks-libev
    shell> vim config.json                      # 编辑配置文件

    {
        "server":"66.98.122.7",                 # 服务器端必须配置为 0.0.0.0
        "server_port":443,                      # 服务器端接收端口
        "local_port":1080,
        "password":"f227777777",                # 服务器端接收验证密码
        "timeout":60,
        "method":"aes-256-cfb"                 # 服务器端加密方式       
    }


3. 防火墙配置
    允许 443 端口接收 TCP 和 UDP 数据包
    shell> iptables -I INPUT -p tcp --dport 8888 -j ACCEPT
    shell> iptables -I INPUT -p udp --dport 8888 -j ACCEPT

4. 启动
    shell> systemctl start shadowsocks-libev.service
    shell> systemctl enable shadowsocks-libev.service
    shell> systemctl status shadowsocks-libev.service
    shell> sudo systemctl restart shadowsocks-libev                 # 重启服务端，因为安装后自动启动的配置文件是默认的，为了使修改后的配置文件生效
    shell> ss-server -c /etc/shadowsocks-libev/congif.json          # 启动 shadowsocks 服务器端服务
    
    
5. 开启 TCP Fast Open
    shell> uname -r         # 查看内核版本
    shell> cat /proc/sys/net/ipv4/tcp_fastopen
    # 以上命令将返回 4 种值，一下是 4 种值的含义
    # 0 means disabled.
    # 1 means it’s enabled for outgoing connection (as a client).
    # 2 means it’s enabled for incoming connection (as a server).
    # 3 means it’s enabled for both outgoing and incoming connection.
    
    shell> vim /etc/sysctl.conf
    添加如下一行
    net.ipv4.tcp_fastopen=3
    
    shell> sysctl -p        # 让上面修改的配置文件生效
    
    修改 shadowsocks 的配置文件
    添加一行 "fast_open": true                       # 开启 tcp fast open，需要执行第 5 步配置才行
    
    
    shell> systemctl restart shadowsocks-libev      # 重启 shadowsocks
    shell> systemctl status shadowsocks-libev       # 检查状态


################################ ubuntu-18.04.1 客户端
1. 安装 shadowsocks-libev
    shell> apt-get install shadowsocks-libev    # 安装 shadowsocks 客户端
 
 
2. 关闭 shadowsocks-libev 服务端，因为安装完成后自动运行
    shell> systemctl stop shadowsocks-libev     # 关闭服务器端程序
    shell> systemctl disable shadowsocks-libev  # 关闭服务气端程序开机自启动   
    
3. shadowsocks-libev 客户端配置
    shell> cd /etc/shadowsocks-libev
    shell> vim config.json                      # 编辑配置文件

    {
        "server":"66.98.122.7",                 # 客户端配置为 服务器的 ip 地址
        "server_port":443,                      # 服务器端接收端口
        "local_port":1080,                      # 客户端本地代理端口
        "password":"f227777777",                # 客户端密码
        "timeout":60,
        "method":"aes-256-cfb"                  # 服务器端加密方式
    }

4. 开启客户端程序
    location-of-your-server 替换为 /etc/shadowsocks-libev/config.json 配置文件的名称，这里替换为 config
    shell> systemctl start shadowsocks-libev-local@location-of-your-server.service 
    shell> systemctl enable shadowsocks-libev-local@location-of-your-server.service
    shell> ss-local -c /etc/shadowsocks/config.json
    
    
5. 检查客户端是否运行
    shell> systemctl status shadowsocks-libev-local@location-of-your-server.service
    
    
6. 浏览器代理配置
    firefox：
        搜索 proxy
        设置 Manual Proxy Configuration
        设置 SOCKS Host 127.0.0.1 port 1080
        选择 SOCKS v5
        勾选 Proxy DNS when using SOCKS v5
        
    chrome：
        google-chrome --proxy-server="socks5://127.0.0.1:1080"
        或者
        安装 SwitchOmega 插件来管理代理

7. Terminal Proxy Settings
    shell> vim /etc/environment
    添加如下行： 用户名：密码可以省略，省略的时候没有 @ 符号
    http_proxy="http://kasei:f227777777@127.0.0.1:8118/"
    https_proxy="http://kasei:f227777777@127.0.0.1:8118/"
    ftp_proxy="http://kasei:f227777777@127.0.0.1:8118/"
    socks_proxy="http://kasei:f227777777@127.0.0.1:1080/"
    no_proxy="localhost,127.0.0.1,::1"
    
    参照 privoxy 软件操作手册
    
8. Desktop Proxy Settings 桌面代理设置
    Settings -> Network -> Network Proxy -> Manual -> 设置代理即可
    



