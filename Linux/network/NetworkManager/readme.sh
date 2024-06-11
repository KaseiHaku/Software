# Infrastructure
# 配置文件位置 /etc/NetworkManager/NetworkManager.conf
# nmcli 命令会自动把所做的修改配置到 /etc/sysconfig/network-scripts/ 目录下面的指定文件中

# 如果 nmcli 命令找不到
#     Debian: shell> apt-get install network-manager


# 相关配置文件：优先级 从低到高，存在同名文件：只取高优先级的
# /var/run/NetworkManager/conf.d/
# /usr/lib/NetworkManager/conf.d/
# /etc/NetworkManager/NetworkManager.conf
# /etc/NetworkManager/conf.d/


shell> man NetworkManager.conf      # 查看配置详情


# device 网卡
shell> nmcli device show            # 查看详细的网卡信息

# hostname
shell> hostname                                 # 查看当前 hostname
shell> nmcli general hostname                   # 同上
shell> nmcli general hostname newHostName       # 修改 hostname

# connection
shell> nmcli connection show        # 查看所有 连接
shell> nmcli connection show id ens33        # 查看 ens33 连接的所有配置信息
shell> nmcli connection show uuid 88df       # 查看 UUID=88df 的连接的所有配置信息

# 配置静态 IP
shell> nmcli connection show id ens33 | cat -n | grep -i xxx    # 找到想要修改的配置
# 对于多值属性
#   property value          # 覆盖整个值，如果原来有多个，修改后只剩一个
#   +property value         # 表示追加一个值
#   -property value         # 表示删除当前 value 匹配的值
shell> nmcli connection modify id ens33 ipv4.addresses 192.168.1.2/24       # 配置 IPv4 地址=192.168.1.2; 子网掩码=255.255.255.0
shell> nmcli connection modify id ens33 ipv4.gateway 192.168.1.1            # 配置 网关
shell> nmcli connection modify id ens33 ipv4.method manual                  # 设置为 静态分配 IP
shell> nmcli connection modify id ens33 ipv4.dns "8.8.8.8"                  # DNS 配置




