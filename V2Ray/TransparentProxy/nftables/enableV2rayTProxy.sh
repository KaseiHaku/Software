#!/bin/bash -e

# 查看 ip 转发是否开启， 1 表示已开启
# echo 'net.ipv4.ip_forward = 1' >! /etc/sysctl.d/enableIPv4Forward.conf        # 首次需手动执行
# sysctl -p                                                                     # 首次需手动执行，使上述配置生效




# 配置防火墙
nft -f /home/kasei/Script/nftablesRuleSet.nft

# 设置策略路由
ip rule add fwmark 2 pref 1024 table 100     # 匹配防火墙标记为 1 的数据包,优先级(preference)为 1024，用 100 号路由表路由
# 在  100 号 路由表 中添加 路由记录: 将 local 类型，目标 IP 为 0.0.0.0/0(default 所有地址) 的数据包，使用网卡 lo 发送数据，坑：当网卡重起时，该配置失效
ip route add table 100 local 0.0.0.0/0 dev lo  

ip -6 rule add fwmark 2 pref 1024 table 100     # 匹配防火墙标记为 1 的数据包,优先级(preference)为 1024，用 100 号路由表路由
ip -6 route add table 100 local ::/0 dev lo     


# 创建定时器
# systemctl link /home/kasei/Script/dig-timer.service        # 首次需手动执行，添加 自动 dig 服务 的 脚本
# systemctl link /home/kasei/Script/dig-timer.timer          # 首次需手动执行，添加 自动 dig 服务 的 定时触发器
systemctl start dig-timer.timer        # 启动 定时触发器
