################################ 杀掉进程 ################################
shell> pkill -9 -u username                # 杀掉指定用户所有进程


################################ 清理用户 ################################
shell> userdel -r username                  # 删除指定用户


################################ 清理定时任务 ################################
shell> rm -f /var/spool/cron/username      # 删除指定用户定时任务
shell> rm -f /var/spool/cron/crontabs/username  # 删除指定用户定时任务
shell> rm -f /var/spool/at/username        # 删除指定用户 at 任务

################################ 清理文件 ################################
shell> find / -user username -exec rm -rf {} \; 2>/dev/null    # 删除系统中指定用户的所有文件
