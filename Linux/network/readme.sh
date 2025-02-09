################################ Concept ################################
术语  Terminology: {
    MTU(Max Trasport Unit/最大传输单元)：
        默认 1500，超过该值就会被丢包
    PMTU(路径 MTU)：
        两台 host 之间所有网络设置的 MTU 值，取最小值
    MSS(Max Segment Size/最大报文段长度):
        表示 TCP 传往另一端的最大块数据的长度。当一个连接建立时，连接的双方都要通告各自的MSS。
        通常 TCP 通信的双方协商这个值，以避免 TCP 分片。
        一般说来，如果没有分段发生，MSS 还是越大越好。报文段越大允许每个报文段传送的数据就越多，相对IP和TCP首部/有效载荷 payload 的比率就越低，就有更高的网络利用率。
        避免分片还能减少 IP 报文数量（每个TCP 分片都会对应一个IP报文），则减少了路由查询，IP/TCP头开销等等网络资源。
        MSS 值通常设置为外出接口上的 MTU 长度减去固定的 IP 首部和 TCP 首部长度。对于一个以太网，MSS 值可达 1460 字节（1500-20-20）
        
    TCP MSS Clamping(TCP 钳制):
        限制 MSS 大小
}


网络协议: {
    shell> less /etc/protocols

}

各命令总览: {
    
    # 网卡/虚拟网卡 配置
    shell> ip link         

    # 路由配置
    shell> ip rule         
    shell> ip route        

    # 网络/连接 配置
    shell> vim xxx.conf         # 直接修改网卡配置文件，相当于 只有一个配置文件
    shell> ip addr              # 只是临时生效，重启后丢失
    shell> nmcli                # 可以有不同的 网络连接配置文件(connection)，类似于 可以自由切换连接哪个 wifi

    # 防火墙 配置
    shell> iptables
    shell> iptables6
    shell> nft

}

网络配置方法 {
    直接修改配置文件 {
        # Debian
        shell> less /etc/network/interfaces          # 查看该文件的说明文档：shell> man interfaces  
        shell> ll /etc/network/interfaces.d
        # shell> systemctl restart networking        # 该命令无效
        shell> reboot

        # CentOS
        shell> vim /etc/sysconfig/network-scripts/ifcfg-ens33        # 用于配置某一张网卡相关参数
        /etc/sysconfig/network-scripts/route-ethX
        
    }
    
    # CentOS 8 以后版本只支持这种方式
    NetworkManager {
        shell> nmcli            # 管理网络
    }
}

    
   
网卡/协议栈 架构 {
    协议栈：netfilter 运行在 协议栈 中
        │
        ├─ 网卡 1
        ├─ 网卡 2
        └─ Bridge 1
    

}


################################ 网络管理命令
# 测试目的主机连通性
    shell> /proc/sys/net/ipv4/icmp_echo_ignore_all              # 查看当前 ping 是否关闭，0 允许，1 关闭
    shell> vim /etc/sysctl.conf                                 # 永久配置 ping 是否关闭，添加一行 net.ipv4.icmp_echo_ignore_all = 1, 0表示允许，1表示禁止
    shell> 查看防火墙是否阻止  icmp 协议数据包
    
    shell> ping -c 4 202.108.22.5 -I [ens33|182.168.1.10]    # 采用指定的网卡发送 ping 数据，该命令中的ip是百度的
    shell> ping -f -s 1500 baidu.com                        # -f    Send Don't Fragment flag in packet(IPv4 only)
                                                            # -s    发送多少个 byte 
    
    
# 测试目的主机的 TCP 端口是否开放
    shell> telnet 192.168.0.1:12345             # 测试 TCP 端口连通性，能连通则黑屏，否则有提示信息

# 查看一个数据包到目的主机的路由路径
    shell> traceroute 8.8.8.8            # Linux 下跟踪数据包路由路径，原理是 一系列 带 TTL 的 ping 命令，如果超时没有返回，则显示 * ，但是实际可能数据已经发出去了
    shell> tracert 8.8.8.8              # Windows 下查看数据包经过的路由器 ip 地址
    

# ip 
# shell> ip addr 中字段解释
#     mngtmpaddr                Manage Temporary Addresses    管理临时地址，IPv6 中用于防止跟踪和提高隐私保护
# 
    shell> ip help                                 # 查看帮助文档
    
    shell> ip neigh help                           # 查看指定命令的帮助文档
    
    shell> ip neigh                                 # 查看
    
    
    shell> ip -d link show                          # -d 查看详细信息，不加不全
    shell> ip link ens33                            # 查看 ens33 这块网卡的信息，省略网卡参数，表示查看所有网卡
    shell> ip link set ens33 promisc on|off         # 开启|关闭网卡的混杂模式（抓包使用）
    shell> ip link set ens33 mtu 1500               # 更改 mtu（Maximum Transmission Unit) 大小   
    shell> ip link set ens33 up|down                # 开启|关闭 ens33 这块网卡
    shell> ip link set ens33 arp on|off             # 开启|关闭 ens33 这块网卡的 arp 功能
    shell> ip link set ens33 multicast on|off       # 开启|关闭 ens33 这块网卡的多播功能
    shell> ip -s link                               # 查看网卡数据统计信息
    
    


    shell> ip addr add IP/MASK dev ens33 lable ens33:   # 给网卡 ens33 添加 ip 地址（可以添加多个 IP 并给别名）
    shell> ip addr dle IP/MASK dev ens33                # 删除网卡 ens33 的 ip 地址
    shell> ip addr flush ens33                          # 清除网卡 ens33 的所有地址


    shell> ip route show                           # 查看路由信息
    shell> ip route add to 10.0.0.0/8 dev ens33 via 172.16.16.1    # 设置路由

    


# ss   
    # https://manpages.debian.org/bookworm/iproute2/ss.8.en.html
    
    shell> ss -h                # 显示帮助信息
    
    shell> ss -n                # 以 IP 地址显示连接的主机名
    shell> ss -r                # 以 域名 显示连接的主机名

    shell> ss -a                # 显示所有 socket
    shell> ss -l                # 显示监听状态的 socket 
    
    shell> ss -e                # 显示详细的 sockets 信息

    shell> ss -p                # 显示 socket 对应的进程信息，包括 pid
    
    shell> ss -raep         

    shell> ss -H    dst = 192.168.0.1 and src = 192.168.0.1            # = 两边必须带空格
                    dport >= [FAMILY:]:3306 or not sport != [FAMILY:]:80        # [FAMILY:] 和 ss 的 -f 选项一样，可以用 * 进行通配
                    dev = devName && dev != ifIdx
                    fwmark = 0x01/0x03 || fwmark != 0x01/0x03
                    cgroup = path && ! cgroup != path
                    autobound        # 用于匹配当 源地址 自动分配的情况
                    


-o,--options    # 显示计时器信息
-m,--memory     # 显示套接字（socket）的内存使用情况
-i,--info       # 显示TCP内部信息
-s,--summary    # 显示套接字（socket）使用概况
-4,--ipv4       # 仅显示IPv4的套接字（sockets）
-6,--ipv6       # 仅显示IPv6的套接字（sockets）
-0,--packet	    # 显示PACKET 套接字（socket）
-t,--tcp        # 仅显示TCP套接字（sockets）
-u,--udp        # 仅显示UCP套接字（sockets）
-d,--dccp       # 仅显示DCCP套接字（sockets）
-w,--raw        # 仅显示RAW套接字（sockets）
-x,--unix       # 仅显示Unix套接字（sockets）


# telnet
    shell> telnet 192.12.32.44 8080     # telnet 远程登录指定 ip 地址主机的指定端口，如果没有返回错误说明该 ip 对应的主机该端口开放


################################# 网卡查看及配置
shell> ip a                     # 查看系统中的网卡
shell> lshw -class network      # 查看网卡

################################# Host 网络主机名称配置
shell> vim /etc/hostname      # 配置网络主机名称

################################# MAC 地址
shell> ip addr                  # 查看网卡 MAC 地址
shell> ip neighbor show         # 查看 ARP(ipv4)/NDP(ipv6) 缓存条目

################################# IP 地址配置
# Debian/Ubuntu 18.04
1. 查看自己的网卡编号，假设为 wlp3s0
    shell> ip a   

2. 打开配置文件
    shell> vim /etc/network/interfaces 

3. 添加或修改如下行（@trap 行尾的注释 是无效的，实际编写时要删除）
    # 配置 loopback 网卡
    auto lo                    # 自动启动名为 lo 的网卡
    iface lo inet loopback     # 将 lo 网卡配置为 IPv4 的 loopback 网卡
    iface lo inet6 loopback    # 将 lo 网卡配置为 IPv6 的 loopback 网卡

    # 无线网卡 
    allow-hotplug wlp3s0            # allow-hotplug 表示该网卡是 热拔插 网卡，检测到了就自动启动
    # 编写网卡 wlp3s0 的 inet(IPv4) 的配置，配置方法为 static(静态 IP)
    iface wlp3s0 inet static
        address 192.168.43.128/24        # 本机 IP/Mask 地址
        gateway 192.168.43.1             # 网关地址，表示在当前局域网内找不到的 IP 地址，直接转发 网关
        # 如果是 无线网卡/Wifi
        wpa-ssid TP-LINK_xxxx            # wifi 名称
        wpa-psk  password                # wifi 密码
    # 编写网卡 wlp3s0 的 inet6(IPv6) 的配置，配置方法为 dhcp(DHCPv6 自动分配)
    iface wlp3s0 inet6 dhcp
        hostname 2408:8240:9416:dc01:2268:9dff:feb9:81f9        # DHCPv6 服务器 IP，不配置默认为: 自动获取
    # 编写网卡 wlp3s0 的 inet6(IPv6) 的配置，配置方法为 auto(SLAAC 自动分配)；一个 inet6 只能选一种进行配置
    #iface wlp3s0 inet6 auto

    # 有线网卡
    auto enp2s0                    # 配置 enp2s0 开机自动启动，auto === allow-auto
    iface enp2s0 inet static
        address 192.168.0.201/24        # 本机 IP/Mask 地址
        gateway 192.168.0.1
    iface enp2s0 inet6 dhcp
    

4. 保存退出

5. 使配置生效
    shell> /etc/init.d/networking restart  
     
6. 查看当前网卡的 ip 地址
    shell> ip address

# CentOS 7




################################# DHCP(Dynamic Host Configuration Protocol) 动态 IP 配置


################################# DNS(Domain Name System) 域名解析服务器配置
# 查看当前系统的 DNS 服务器
    shell> systemd-resolve --status


# 配置本地域名解析服务 
1. 打开配置文件
    shell> vim /etc/hosts           


# 配置网络 DNS 域名解析服务器
1. 打开配置文件
    shell> vim /etc/systemd/resolved.conf     

2. 添加或修改如下
    [Resolve]
    DNS=223.5.5.5 8.8.8.8   # 修改为 阿里 和 谷歌 的域名解析服务器
    #FallbackDNS=
    #Domains=
    LLMNR=no            # 设置的是禁止运行LLMNR(Link-Local Multicast Name Resolution)，否则systemd-resolve会监听5535端口。
    #MulticastDNS=no
    #DNSSEC=no
    #Cache=yes
    #DNSStubListener=yes


3. 保存退出即可


################################# Route 路由配置
shell> vim /etc/sysconfig/network-scripts/route-ens33       # 查看某一张网卡的路由配置



################################# Port 端口配置
shell> vim /etc/services            # 查看本地不同端口对应的网络服务

shell> lsof -i:22                   # 查看指定端口



################################# Protocol 协议配置
shell> vim /etc/protocols           # 查看本机使用的协议以及各个协议的协议号


























