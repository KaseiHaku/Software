# 禁 ping
shell> cat <<-'EOF' | tee /etc/sysctl.d/00-security.conf
net.ipv4.icmp_echo_ignore_all = 1
net.ipv6.icmp.echo_ignore_all = 1
EOF
shell> sysctl --system

# 配置登陆失败后，指定账号一段时间内禁止登陆
shell> grep 'UsePAM' /etc/ssh/sshd_config                # 确保值为 yes
shell> ll /etc/pam*
shell> cd /etc/pam.d


# 配置 ssh 登陆白名单
shell> grep 'AllowUsers' /etc/ssh/sshd_config            # 查询并修改指定值; 例如: AllowUsers your_username@192.168.1.100 your_username@10.0.0.1
# AllowUsers root                                        # 不限制 IP
# AllowUsers root@192.168.1.100 root@10.0.0.1           # 限制为指定 IP 
shell> systemctl restart sshd                            # 重启 ssh 服务端

# 禁止 root 直接登录
shell> grep 'PermitRootLogin' /etc/ssh/sshd_config        # 并将值从 yes 修改为 no
shell> systemctl restart sshd            # 重启 ssh 服务端

# 免密登陆
shell> ssh-keygen        # client 端生成 密钥对; pubkey 一般保存在 ~/.ssh/id_rsa.pub 目录中; id 文件一般保存在 ~/.ssh/id_rsa 文件中
shell> ssh-copy-id -l root -p 22 192.168.0.200        # 将公钥发送到 server 端
