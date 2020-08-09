#!/bin/bash
# TODO 基于 tproxy 方式的透明代理
# 基于 nftables 的脚本




# 基于 iptables 的脚本
# 代理局域网设备
iptables -t mangle -N V2RAY 
iptables -t mangle -A V2RAY -p udp -m multiport --dports 123 -j RETURN  # 放行 ntp 协议
iptables -t mangle -A V2RAY -d 127.0.0.0/8 -j RETURN       # 回环地址
iptables -t mangle -A V2RAY -d 192.168.0.0/16 -p tcp -m multiport ! --dports 53,5353 -j RETURN # 直连局域网，53 端口除外（因为要使用 V2Ray 解析 DNS），避免 V2Ray 无法启动时无法连网关的 SSH，如果你配置的是其他网段（如 10.x.x.x 等），则修改成自己的
iptables -t mangle -A V2RAY -d 192.168.0.0/16 -p udp -m multiport ! --dports 53,5353 -j RETURN # 直连局域网，53 端口除外（因为要使用 V2Ray 解析 DNS）
iptables -t mangle -A V2RAY -m set --match-set vps4 dst -j RETURN    # 如果目标 ip 地址在名为 vps4 的 ipset 中，那么放行
iptables -t mangle -A V2RAY -p udp -j TPROXY --on-port 12345 --tproxy-mark 1 # 给 UDP 打标记 1，转发至 12345 端口
iptables -t mangle -A V2RAY -p tcp -j TPROXY --on-port 12345 --tproxy-mark 1 # 给 TCP 打标记 1，转发至 12345 端口
iptables -t mangle -A PREROUTING -j V2RAY # 应用规则

# 代理网关本机
iptables -t mangle -N V2RAY_MASK 
iptables -t mangle -A V2RAY_MASK -p udp -m multiport --dports 123 -j RETURN  # 放行 ntp 协议
iptables -t mangle -A V2RAY_MASK -d 127.0.0.0/8 -j RETURN       # 回环地址
iptables -t mangle -A V2RAY_MASK -d 192.168.0.0/16 -p tcp -m multiport ! --dports 53,5353 -j RETURN # 直连局域网，53 端口除外（因为要使用 V2Ray 解析 DNS）
iptables -t mangle -A V2RAY_MASK -d 192.168.0.0/16 -p udp -m multiport ! --dports 53,5353 -j RETURN # 直连局域网，53 端口除外（因为要使用 V2Ray 解析 DNS）
iptables -t mangle -A V2RAY_MASK -m set --match-set vps4 dst -j RETURN    # 如果目标 ip 地址在名为 vps4 的 ipset 中，那么放行
iptables -t mangle -A V2RAY_MASK -m mark --mark 255 -j RETURN    # 直连 SO_MARK 为 0xff 的流量(0xff 是 16 进制数，数值上等同与上面V2Ray 配置的 255)，此规则目的是避免代理本机(网关)流量出现回环问题
iptables -t mangle -A V2RAY_MASK -p udp -j MARK --set-mark 2   # 给 UDP 打标记,重路由
iptables -t mangle -A V2RAY_MASK -p tcp -j MARK --set-mark 2   # 给 TCP 打标记，重路由
iptables -t mangle -A OUTPUT -j V2RAY_MASK # 应用规则

# 设置策略路由
ip rule add fwmark 2 pref 1024 table 100     # 匹配防火墙标记为 1 的数据包,优先级(preference)为 1024，用 100 号路由表路由
ip route add table 100 local 0.0.0.0/0 dev lo  # 为 100 号路由表添加路由策略: 目标IP为 0.0.0.0/0(default 所有地址) 的数据包，使用网卡 lo 发送数据，坑：当网卡重起时，该配置失效
