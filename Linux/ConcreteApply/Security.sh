################################ 禁 ping ################################
# 
shell> cat <<-'EOF' | tee /etc/sysctl.d/00-security.conf
net.ipv4.icmp_echo_ignore_all = 1
net.ipv6.icmp.echo_ignore_all = 1
EOF
shell> sysctl --system

################################ sshd 配置 ################################
# 
# sshd 安全配置：一键配置 sshd_config
shell> cat <<-'EOF' | tee /etc/ssh/sshd_config.d/kh.conf
# yes    开启 Pulggable Authentication Module interface
UsePAM yes

# 禁止 root 直接登录
# no     禁止 root 用户远程登陆
PermitRootLogin no

# 6      密码最多错误 6 次，失败后锁定
MaxAuthTries 6

# 打印登陆日志
PrintLastLog yes

# 白名单：只允许指定用户登陆
# AllowUsers root                                                        # 不限制 IP
# AllowUsers root@192.168.1.100 root@10.0.0.1 kasei@192.168.0.0/24       # 限制为指定 IP 
AllowUsers kasei@192.168.0.0/24

# no     禁用 空串 密码
PermitEmptyPasswords no

# yes    禁止 rhosts
IgnoreRhosts yes

# 可用的认证方式配置
# 有 Pubkey Password 等
PubkeyAuthentication yes
PasswordAuthentication yes

# 自动关闭空闲连接
# ClientAliveInterval 1200    如果超过 1200 秒没有接收到 client 的数据，那么发送一个探活心跳
# ClientAliveCountMax 3       探活心跳超过 3 次还是没回应直接断开 client 连接
ClientAliveInterval 1200
ClientAliveCountMax 3
EOF
shell> systemctl restart sshd            # 重启 ssh 服务端


################################ 配置多次密码失败后锁定 ################################
# 
# 配置登陆失败后，指定账号一段时间内禁止登陆
shell> grep 'UsePAM' /etc/ssh/sshd_config                # 确保值为 yes
shell> ll /etc/pam*



# PAM(Pluggable Authentication Modules) 配置 (Debian 11) 以后
shell> less /etc/pam.conf         # PAM 配置文件
shell> ll /etc/pam.d            # PAM 配置目录
shell> find / -iname 'pam_faillock.so'  # 检查 PAM 是否安装，如果不存在，则需要安装

# 修改锁定配置
shell> vim /etc/security/faillock.conf 
# 允许最大错误尝试次数
deny = 3
# 指定时间间隔内，最多尝试 deny 次，单位：秒
fail_interval = 900
# 锁定 600 秒后自动解锁
unlock_time = 600
# root 也有错误次数限制
even_deny_root
# root 锁定 900 秒自动解锁
root_unlock_time = 900

# 修改配置文件
shell> man pam.d
shell> cd /etc/pam.d
shell> cp /etc/pam.d/common-auth /etc/pam.d/common-auth.bak
shell> vim /etc/pam.d/common-auth  
# 原配置
#auth    [success=1 default=ignore]      pam_unix.so nullok
#auth    requisite                       pam_deny.so
#auth    required                        pam_permit.so
# 修改成以下内容
auth    requisite                       pam_faillock.so preauth silent
auth    [success=4 default=ignore]      pam_unix.so nullok
auth    [default=die]                   pam_faillock.so authfail   
auth    sufficient                      pam_faillock.so authsucc
auth    requisite                       pam_deny.so
auth    required                        pam_permit.so


shell> faillock --user username       # 可以用来解锁


################################ 免密登陆 配置 ################################
shell> ssh-keygen        # client 端生成 密钥对; pubkey 一般保存在 ~/.ssh/id_rsa.pub 目录中; id 文件一般保存在 ~/.ssh/id_rsa 文件中
shell> ssh-copy-id -l root -p 22 192.168.0.200        # 将公钥发送到 server 端

################################ Troubleshoot ################################
shell> alias -p                        # 检查是否有异常的 别名
shell> less /var/log/auth.log            # 查看异常认证信息
shell> less /var/log/secure                # ditto
shell> ss -lnep                         # 检查异常 port
shell> lsof -p PID                    # 查看指定 PID 打开的所有文件
shell> less /etc/passwd         # 排查异常账户
shell> less /etc/shadow        # 排查异常账户
shell>  # 排查定时任务
shell> echo $PATH # 检查常用命令是否被修改过; /usr/bin /usr/sbin
shell> rpm -VF /usr/bin/*        # 验证该目录下的文件是否被修改过，如果被修改过则需要恢复; CentOS 中

