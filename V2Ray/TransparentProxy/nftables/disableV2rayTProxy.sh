#!/bin/bash -e

# 清理定时任务
systemctl stop dig-timer.timer

# 清理 nftables
#nft flush ruleset                        # 改为明确删除，而不是全删，防止误删 docker 的配置
nft delete table ip tb_v2ray
nft delete table ip6 tb_v2ray_ip6
nft delete table inet tb_divert

# 清理 路由策略
ip rule del fwmark 2 pref 1024 table 100
ip route del table 100 local 0.0.0.0/0  dev lo onlink

ip -6 rule del fwmark 2 pref 1024 table 100
ip -6 route del table 100 local ::/0 dev lo onlink


