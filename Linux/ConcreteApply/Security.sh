################################ 禁 ping ################################
# 
shell> cat <<-'EOF' | tee /etc/sysctl.d/00-security.conf
net.ipv4.icmp_echo_ignore_all = 1
net.ipv6.icmp.echo_ignore_all = 1
EOF
shell> sysctl --system

################################ sshd 配置 ################################
# sshd 安全配置：一键配置 sshd_config
# 
# 修改 ssh 默认端口
shell> vim /etc/ssh/sshd_config
# 修改默认端口，可以减少很多自动化攻击
# @tips 可以存在多个 Port 46531 行，sshd 会同时监听所有 Port 行中的配置
# @trap 添加 Port 时，应该先添加，然后测试新 port，测试通过后，再关闭老的 port;  
#       注意每次修改后需要 shell> systemctl restart sshd
#Port 22
Port 46530

# 修改端口 添加自定义 sshd 配置
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
# @巨神坑 一定要开两个 tty，一个用来改文件，一个用于登录测试
#        如果只开一个 tty，万一修改错误，将会导致服务器无法登录

# 配置登陆失败后，指定账号一段时间内禁止登陆
shell> grep 'UsePAM' /etc/ssh/sshd_config                # 确保值为 yes
shell> ll /etc/pam*

# PAM(Pluggable Authentication Modules) 配置 (Debian 11) 以后
shell> less /etc/pam.conf         # PAM 配置文件
shell> ll /etc/pam.d            # PAM 配置目录
shell> find / -iname 'pam_faillock.so'  # 检查 PAM 是否安装，如果不存在，则需要安装
shell> apt install libpam-modules        # 安装

# 修改锁定配置
shell> vim /etc/security/faillock.conf 
deny = 3                        # 允许最大错误尝试次数
fail_interval = 900            # 900 秒内，密码错误 deny 次(不需要连续)，那么账号就会被锁定
unlock_time = 600                # 锁定 600 秒后自动解锁
even_deny_root                    # root 也有错误次数限制
root_unlock_time = 900            # root 锁定 900 秒自动解锁

# 备份配置文件
shell> cd /etc/pam.d
shell> cp /etc/pam.d/common-auth /etc/pam.d/common-auth.bak
shell> cp /etc/pam.d/common-account /etc/pam.d/common-account.bak

# 查看配置文件帮助文档
shell> man pam.d                            # 查看 /etc/pam.d 下文件内容的格式
shell> man pam_faillock                    # 查看 /lib/x86_64-linux-gnu/security/pam_faillock.so 怎么用

# 修改认证(auth)配置
# 文件内容格式：service type control module-path module-arguments
# service                        # 在 /etc/pam.d 目录下，由文件名替代
# type                            # account, auth, password, session
# control                        # required, requisite, sufficient, optional, include, substack, [value1=action1 value2=action2 ...]
# module-path                    # 绝对路径; 相对于 /lib/security/ or /lib64/security/ 的相对路径
# module-arguments                # [query=select user_name]  如果参数包含空格，那么需要放到 [] 中
shell> vim /etc/pam.d/common-auth  
# 原配置
#auth    [success=1 default=ignore]      pam_unix.so nullok
#auth    requisite                       pam_deny.so
#auth    required                        pam_permit.so
# 修改成以下内容
# @kasei
auth    requisite                       pam_faillock.so preauth
auth    [success=1 default=ignore]      pam_unix.so nullok                    # success=1 表示 success 时，跳过下一条规则; default=ignore 表示其他情况忽略当前规则的结果
auth    [default=die]                   pam_faillock.so authfail   
auth    sufficient                      pam_faillock.so authsucc
auth    requisite                       pam_deny.so
auth    required                        pam_permit.so

# 修改账号(account)配置
shell> vim /etc/pam.d/common-account
# @kasei 添加一行到头部
account required                        pam_faillock.so

# 更新 PAM 配置，使配置生效
# 交互式界面:
#     按 方向键 移动
#     按 空格键 选中/取消选中模块
#     按 Enter 确认更改
shell> pam-auth-update --force  

shell> faillock --user username       # 可以用来解锁， Valid 列: V 代表锁定有效，I 代表锁定无效;
shell> rm /var/run/faillock/<username> # 删除文件解锁
shell> faillock --user username --reset # 命令解锁，推荐


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

