################################ Troubleshoot ################################

外部服务器无法访问 docker 容器，即使开了端口:
    shell> docker top ??? -ef                       # 查看容器对应的 pid
    shell> nsenter -t 169766 -n ip addr             # 查看容器内的信息

    # 检查路由规则
    shell> ip rule show                     # 查看所有 IPv4 路由规则
    shell> ip route list table 0            # 查看 0 号路由表中的规则，该表系统保留
    shell> ip route list table local        # 查看 255 号(本地)路由表中的路由规则
    shell> ip route list table main         # 查看 254 号(主)路由表中的路由规则
    shell> ip rotue list table default      # 查看 253 号(默认)路由表中的路由规则

    # 检查防火墙规则 
    # 表先后顺序: raw > mangle > nat > filter
    # 链先后顺序: prerouting > (input, output); forward > postrouting
    shell> iptables -t raw -S               
    shell> iptables -t mangle -S
    shell> iptables -t nat -S
    shell> iptables -t filter -S


    # 流量监控
    shell> docker exec ??? cat /sys/class/net/eth0/iflink       # 查看容器中的虚拟网卡 eth0 对应的 if，假设输出值=32
    shell> grep '32' /sys/class/net/*/ifindex                   # 输出内容中的 文件路径 中的 网卡地址 就是与 容器中 eth0 对等的 在 host 上的虚拟网卡
    shell> tcpdump -i veth??? -nn dst port 8080                 # 监控网卡流量


    # 插入 debug 信息
    # @trap 如果没有打印日志，那么参考 https://github.com/KaseiHaku/Software/blob/master/Linux/network/FireWall/iptables_usage.txt 进行配置
    shell> iptables -t raw -I PREROUTING 1 -s 10.7.20.90 -j TRACE 
    shell> tail -fn 500 /var/log/messages
    
    
    
