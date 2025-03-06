# 参考文章 https://shibd.github.io/message-center-3/

################################ Concept ################################  
# Linux 内核是通过 (local_ip, local_port, remote_ip, remote_port) 四元组来标识一条 TCP 连接的
# 由于 local_port 最大值为 65535，所以常规 (local_ip, local_port) 最多只能支持 65535 个 TCP 连接
# 突破该限制的方法是：给 host 配置多个 虚拟 IP 或 增加网卡，总之就是增加 local_ip 的数量
# 
# nginx 本身限制了 websocket 连接数量怎么办
#     使用 LVS(Linux Virtual Server) + DR 来负载均衡
# 


################################ 突破 1024 ################################ 
# 可能报错:
#   open file many
# 解决方法:
#   调整最大文件描述符数量
# 
# 修改  系统最大打开文件描述符数
shell> echo 'fs.file-max = 1000000' >> /etc/sysctl.conf      
# 修改  进程最大打开文件描述符数，打开并增加如下行
shell> vim /etc/security/limits.conf                         
*         hard    nofile      1000000
*         soft    nofile      1000000
root      hard    nofile      1000000
root      soft    nofile      1000000
# @trap 还有一点要注意的就是 hard limit 不能大于/proc/sys/fs/nr_open，因此有时你也需要修改 nr_open 的值
shell> echo 2000000 > /proc/sys/fs/nr_open


################################ 突破 1w ################################ 
# 可能报错原因:
#   tomcat 默认最大连接数是 10000
# 解决方法:
#   1 在 application.yml 中修改tomcat最大连接数 server.tomcat.max-connections: 1000000
#   2 更换Spring默认的web容器为undertow，修改pom文件

shell> tcpdump -i lo          # 可以查看 TCP 握手是否成功，可以确定是否是操作系统本身的问题，还是应用程序的问题
shell> jstat -gc pid           # 查看内存使用情况
shell> jstack pid              # 查看线程状态，查看处于 WAITING 状态的线程，并查看线程栈是哪个方法导致的

################################ 突破 3w ################################ 
# 可能报错原因:
#   Caused by: java.net.BindException: Cannot assign requested address
# 解决方法:
#   减少操作系统的预留端口
# 
shell> vim /etc/sysctl.conf
shell> net.ipv4.ip_local_port_range = 1024 65535
shell> sysctl -p

################################ 突破 4w ################################ 
# 可能报错原因:
#   OOM
# 解决方法:
#   增加 jvm 内存
shell> java -Xmx10G -Xms8G

################################ 突破 6w ################################ 
# 可能报错原因:
#   Cannot assign requested address
# 解决方法:
#   1 增加更多物理网卡
#   2 增加虚拟网卡
shell> ifconfig eth0:0 192.168.10.10 netmask 255.255.255.0 up
shell> ifconfig eth0:1 192.168.10.11 netmask 255.255.255.0 up
shell> ifconfig eth0:2 192.168.10.12 netmask 255.255.255.0 up

################################ 突破 7w ################################ 
# 可能报错原因:
#   The HTTP request to initiate the WebSocket connection failed
#   使用 tcpdump 连 TCP 握手的包都抓不到
#   使用 dmesg 命令查看系统信息，发现有大量的 nf_conntrack: table full, dropping packet 日志。问题很明显，nf_conntrack 模块报错丢弃了包。
# 解决方法:
shell> echo 'net.nf_conntrack_max = 2000000' >> /etc/sysctl.conf
shell> sysctl -p

################################ 突破 50w ################################ 
# 可能报错原因:
#   使用 dmesg 命令查看，发现出现大量 TCP: too many of orphaned sockets 的错误，错误显示 tcp socket 过多
# 解决方法:
#   调整 tcp socket 参数
shell> echo "net.ipv4.tcp_mem = 786432 2097152 3145728" >> /etc/sysctl.conf
shell> echo "net.ipv4.tcp_rmem = 4096 4096 16777216" >> /etc/sysctl.conf
shell> echo "net.ipv4.tcp_wmem = 4096 4096 16777216" >> /etc/sysctl.conf
shell> sysctl -p
