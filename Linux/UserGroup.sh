################################ Linux 用户及用户组管理 ######################
                                       
# 用户相关命令 #########################    
shell> su - root                            # 切换到 root 用户
shell> w                                    # 查看当前已经登录的所有用户

shell> cat /etc/passwd                      # 查看所有用户账号，格式 = 用户名:口令:用户标识号:组标识号:注释性描述:主目录:登录 Shell
                                            # 用户标识号：0 是超级用户 root 的标识号; 1~99: 预定义用户; 100～999: 系统用户;
                                            # 登陆 Shell ： 登陆 Shell 为空，表示该用户时伪用户 pseudo user，它们的存在主要是方便系统管理，满足相应的系统进程对文件属主的要求。

shell> cat /etc/shadow                      # 查看所有账号的密码，格式 = 登录名:加密口令:最后一次修改时间:最小时间间隔:最大时间间隔:警告时间:不活动时间:失效时间:标志

shell> useradd -c 'my username' kasei           # 添加用户，并添加注释，用于描述该用户
shell> useradd -d /home/kasei kasei             # 添加用户的同时，指定用户主目录
shell> useradd -d /home/kasei -m kasei          # 添加用户的同时，指定用户主目录，如果主目录不存在，则创建
shell> useradd -M kasei                         # 不创建该用户的 home 目录

shell> useradd -g dba kasei                     # 添加用户的同时，指定用户所属的 主用户组
shell> useradd -G guest,stranger kasei          # 添加用户的同时，指定用户所属的 附加用户组 为 guest 和 stranger; 全量覆盖
shell> useradd -a -G guest kasei                # 添加用户的同时，将用户 新加入到一个 guest 用户组

shell> useradd -s /bin/bash kasei               # 指定用户所使用的 shell
shell> useradd -s /usr/sbin/nologin kasei       # 创建一个无法通过 ssh 登陆的用户
shell> useradd -u 1024 kasei                    # 指定新建用户的 UID，如果 UID 存在，则创建失败
shell> useradd -u 1024 -o kasei                 # 指定新建用户的 UID，如果 UID 存在，则重复使用其他用户的 UID


shell> userdel -r kasei                         # 完全删除用户账号


shell> usermod -l haku kasei                # 修改用户名为 kasei
shell> usermod -c -d -m -s -u               # 跟 useradd 中一样的
               -g -G -a                     # 用户组相关


shell> passwd -l kasei                  # 禁用该账号
shell> passwd -u kasei                  # 解禁该账号
shell> passwd -d kasei                  # 使账号无口令
shell> passwd -f kasei                  # 强制该用户下次登录时修改口令
shell> echo xxx | passwd --stdin root   # 修改 root 账号的密码为 xxx

shell> newgrp root                      # 将当前用户切换到 root 用户组
shell> id userName                      # 查看指定用户的 UID



# 用户组相关命令 #######################
shell> groups                       # 查看当前 user 所在的所有用户组
shell> cat /etc/group               # 查看所有用户组， 格式 = group_name:passwd:GID:user_list    
shell> cat /etc/gshadow             # 存储所有组账号的密码， 格式 = group_name:passwd:管理员账号1,管理员账号2:组成员1,组成员2
	
shell> groupadd -g 128 dba          # 新建用户组 dba，并指定 GID 为 128，如果 128 存在，则新建失败
shell> groupadd -g 128 -o dba       # 新建用户组 dba，并指定 GID 为 128，如果 128 存在，则复用

shell> groupdel dbs                 # 删除用户组

shell> groupmod -n admin dba        # 将 dba 重命名为 admin




