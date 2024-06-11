网络配置方法 {
    直接修改配置文件 {
        /etc/sysconfig/network-scripts/ifcfg-ethX
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
    
    
# 测试目的主机的 TCP 端口是否开放
    shell> telnet 192.168.0.1:12345             # 测试 TCP 端口连通性，能连通则黑屏，否则有提示信息

# 查看一个数据包到目的主机的路由路径
    shell> traceroute 8.8.8.8            # Linux 下跟踪数据包路由路径，原理是 一系列 带 TTL 的 ping 命令，如果超时没有返回，则显示 * ，但是实际可能数据已经发出去了
    shell> tracert 8.8.8.8              # Windows 下查看数据包经过的路由器 ip 地址
    

# ip 
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
# 
################ Debain 配置文件位置
shell> less /etc/network/interfaces
shell> ll /etc/network/interfaces.d

################ CentOS 配置文件位置
shell> vim /etc/sysconfig/network-scripts/ifcfg-ens33        # 用于配置某一张网卡相关参数



shell> ip a                     # 查看系统中的网卡
shell> lshw -class network      # 查看网卡

################################# Host 网络主机名称配置
shell> vim /etc/hostname      # 配置网络主机名称


################################# IP 地址配置
# Ubuntu 18.04
1. 查看自己的网卡编号，假设为 wlp3s0
    shell> ip a   

2. 打开配置文件
    shell> vim /etc/network/interfaces 

3. 添加或修改如下行
    auto wlp3s0
    iface wlp3s0 inet static
    address 192.168.43.128          # 本机 IP 地址
    netmask 255.255.255.0           # 子网掩码
    gateway 192.168.43.1            # 网关地址，表示在当前局域网内找不到的 IP 地址，直接转发 网关
    
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























