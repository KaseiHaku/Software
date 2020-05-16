#!/bin/bash
# todo 老版本 redirect 方式的 透明代理 
# iptables -t nat -N V2RAY_LOCAL                         
# iptables -t nat -A OUTPUT -p tcp -j V2RAY_LOCAL       
# iptables -t nat -A OUTPUT -p udp -j V2RAY_LOCAL      
# iptables -t nat -A V2RAY_LOCAL -m set --match-set vps4 dst -j RETURN      # 如果目标 ip 地址在名为 vps4 的 ipset 中，那么放行
# iptables -t nat -A V2RAY_LOCAL -d 192.168.0.0/16 -j RETURN                # 如果目标 ip 地址是私有地址，那么放行
# iptables -t nat -A V2RAY_LOCAL -d 127.0.0.0/8 -j RETURN
# iptables -t nat -A V2RAY_LOCAL -p tcp -j REDIRECT --to-ports 12345  
# iptables -t nat -A V2RAY_LOCAL -p udp --dport 53 -j REDIRECT --to-ports 12345 



# todo 新版本，基于 tproxy 方式的透明代理
# 代理局域网设备
iptables -t mangle -N V2RAY
iptables -t mangle -A V2RAY -d 127.0.0.1/32 -j RETURN
iptables -t mangle -A V2RAY -d 224.0.0.0/4 -j RETURN 
iptables -t mangle -A V2RAY -d 255.255.255.255/32 -j RETURN 
iptables -t mangle -A V2RAY -d 192.168.0.0/16 -p tcp -j RETURN # 直连局域网，避免 V2Ray 无法启动时无法连网关的 SSH，如果你配置的是其他网段（如 10.x.x.x 等），则修改成自己的
iptables -t mangle -A V2RAY -d 192.168.0.0/16 -p udp ! --dport 53 -j RETURN # 直连局域网，53 端口除外（因为要使用 V2Ray 的 
iptables -t mangle -A V2RAY -m set --match-set vps4 dst -j RETURN    # 如果目标 ip 地址在名为 vps4 的 ipset 中，那么放行
iptables -t mangle -A V2RAY -p udp -j TPROXY --on-port 12345 --tproxy-mark 1 # 给 UDP 打标记 1，转发至 12345 端口
iptables -t mangle -A V2RAY -p tcp -j TPROXY --on-port 12345 --tproxy-mark 1 # 给 TCP 打标记 1，转发至 12345 端口
iptables -t mangle -A PREROUTING -j V2RAY # 应用规则

# 代理网关本机
iptables -t mangle -N V2RAY_MASK 
iptables -t mangle -A V2RAY_MASK -d 224.0.0.0/4 -j RETURN 
iptables -t mangle -A V2RAY_MASK -d 255.255.255.255/32 -j RETURN 
iptables -t mangle -A V2RAY_MASK -d 192.168.0.0/16 -p tcp -j RETURN # 直连局域网
iptables -t mangle -A V2RAY_MASK -d 192.168.0.0/16 -p udp ! --dport 53 -j RETURN # 直连局域网，53 端口除外（因为要使用 V2Ray 的 DNS）
iptables -t mangle -A V2RAY_MASK -m set --match-set vps4 dst -j RETURN    # 如果目标 ip 地址在名为 vps4 的 ipset 中，那么放行
iptables -t mangle -A V2RAY_MASK  -m mark --mark 255 -j RETURN    # 直连 SO_MARK 为 0xff 的流量(0xff 是 16 进制数，数值上等同与上面V2Ray 配置的 255)，此规则目的是避免代理本机(网关)流量出现回环问题
iptables -t mangle -A V2RAY_MASK -p udp -j MARK -set-mark 1   # 给 UDP 打标记,重路由
iptables -t mangle -A V2RAY_MASK -p tcp -j MARK --set-mark 1   # 给 TCP 打标记，重路由
iptables -t mangle -A OUTPUT -j V2RAY_MASK # 应用规则))

# 设置策略路由
ip rule add fwmark 1 pref 1024 table 100     # 匹配防火墙标记为 1 的数据包,优先级(preference)为 1024，用 100 号路由表路由
ip route add table 100 local 0.0.0.0/0 dev lo  # 为 100 号路由表添加路由策略: 目标IP为 0.0.0.0/0(default 所有地址) 的数据包，使用网卡 lo 发送数据，
