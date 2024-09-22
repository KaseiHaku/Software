######## Linux 定时任务



# 相关文件目录
    /etc/crontab                # 定时任务配置文件 
    /etc/cron.d/*               # 定时任务配置文件 保存目录，即: /etc/crontab 文件的分文件格式
                                # 格式: 
                                #   shell> man 4 crontabs       # 帮助
                                #   shell> cat /etc/crontab     # 帮助
                                # 
                                #   Example of job definition:
                                #   .---------------- minute (0 - 59)
                                #   |  .------------- hour (0 - 23)
                                #   |  |  .---------- day of month (1 - 31)
                                #   |  |  |  .------- month (1 - 12) OR jan,feb,mar,apr ...
                                #   |  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
                                #   |  |  |  |  |
                                #   *  *  *  *  * user-name  command to be executed
                                #   0  0  *  *  7 root  date            # 每周日运行
    
    /etc/cron.hourly            # 每小时定时执行的 脚本文件 的保存目录     
    
    /etc/cron.deny
    /etc/cron.allow
    /var/spool/cron             # shell> crontab -e 编辑的定时任务保存位置
    /var/spool/cron/username    # shell> crontab -e 编辑的定时任务保存位置，根据 username 分类
    /var/log/cron.log           # crontab 日志
    
    
# 定时任务 服务
    shell> systemctl status crond
    
    
    shell> tail -fn 1000 /var/log/cron.log          # crontab 日志
    
# 定时任务
    shell> cat <<"EOF" | tee /etc/cron.d/docker-prune
    # 定时清理多余 docker image 文件
    SHELL=/bin/bash
    PATH=/sbin:/bin:/usr/sbin:/usr/bin
    MAILTO=root

    # 测试，巨神坑：特殊字符
    #* * * * * root date +"\%Y-\%m-\%dT\%H:\%M:\%S" >> /opt/cron.log
    
    # 星期天 凌晨 0 点 定时清理多余 docker image 文件，最后一个 0 表示星期天
    0 0 * * 0 root mkdir -p /opt/docker && date +"\%Y-\%m-\%dT\%H:\%M:\%S" >> /opt/docker/prune.log && docker image prune -f >> /opt/docker/prune.log
    EOF
    
    
