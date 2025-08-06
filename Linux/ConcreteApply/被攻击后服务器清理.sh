################################ 记录被攻击日志 ################################
shell> mkdir /evidence                            # 创建证据记录
shell> cp -a /var/log /evidence/logs_backup        # 备份被攻击记录

shell> less /var/log/auth.log        # 查看认证日志

################################ 清理定时任务 ################################
shell> ls -la /etc/cron* /var/spool/cron/*        # 检查定时任务

shell> rm -f /var/spool/cron/username      # 删除指定用户定时任务
shell> rm -f /var/spool/cron/crontabs/username  # 删除指定用户定时任务
shell> rm -f /var/spool/at/username        # 删除指定用户 at 任务

################################ 检查异常的监听端口 ################################
shell> ss -tualnp            # 查看异常的监听端口


################################ 杀掉进程 ################################
shell> ls -la /proc/[0-9]*/exe 2>/dev/null | grep deleted        # 查看异常进程
shell> pkill -9 -u username                # 杀掉指定用户所有进程

################################ 清理文件 ################################
shell> find / -type f -mtime -7 -print | grep -v "/proc/" | grep -v "/sys/"        # 查看最近 7 天内修改过的文件
shell> find / -name "..*" -print    # 查找其他可疑文件
shell> find / -name "..." -print    # 查找其他可疑文件

shell> find / -user username -mtime -2       # 查找指定用户的所有文件
shell> find / -user username -exec rm -rf {} \; 2>/dev/null    # 删除系统中指定用户的所有文件

################################ 清理用户/用户组 ################################
# user
shell> less /etc/passwd
shell> userdel -r username                  # 删除指定用户

# group
shell> less /etc/group
shell> less /etc/gshadow
shell> groupdel groupname                    # 

################################ 清理 sudo 配置 ################################
shell> visudo -c            # 检查 sudo 配置是否更改
shell> less /etc/sudoers            # 检查 sudo 文件是否被修改
shell> ll -al /etc/sudoers.d/        # 逐个检查是否有 异常 sudo 配置文件

################################ 清理 ssh 登录公钥配置 ################################
shell> grep -r "ssh-rsa" /home/*/.ssh/authorized_keys /root/.ssh/authorized_keys        # 检查是否有异常的 ssh 登录公钥配置





