

Query：
    服务文件：
    shell> systemctl -a list-unit-files                     # 列出所有服务的文件
    
    服务实例：
    shell> systemctl list-units                             # 列出已知的所有服务
    shell> systemctl list-sockets                           # 列出所有服务监听的端口
    shell> systemctl list-timers                            # 列出所有服务的运行时间
    shell> systemctl list-dependencies                      # 列出所有服务的依赖关系
    
    shell> systemctl --failed                                       # 查看启动失败的服务
    shell> systemctl status postfix.service                         # 显示一个服务的状态
    
Operate:
    shell> systemctl daemon-reload                                  # 当 unit-file 变更后，需要使用该命令重新加载
    shell> systemctl start postfix.service                          # 启动一个服务
    shell> systemctl start postfix@arg1.service                     # 启动服务时，传入参数(有且只有一个)，在 template-unit-file 中使用 %i 来获取该参数值; shell> man systemd.unit
    shell> systemctl stop postfix.service                           # 关闭一个服务
    shell> systemctl restart postfix.service                        # 重启一个服务

    shell> systemctl is-enabled postfix.service                     # 查看指定服务 是否开机自启动
    shell> systemctl enable postfix.service                         # 开机时启动一个服务
    shell> systemctl disable postfix.service                        # 开机时禁用一个服务
    
Create&Update:
    
    shell> touch ~/customized.service           # 创建一个 .service 文件
    shell> vim ~/customized.service             # 编辑该文件，文件内容参考当前目录下的 customized.service 文件
    shell> cp ~/customized.service /etc/systemd/system  # 复制，/usr/lib/systemd/system 目录下存放的都是开机自启动的服务
    shell> chmod 754 /etc/systemd/system/customized.service     # 修改文件的权限
    
    shell> systemctl link ~/customized.service      # 一步包含所有上述复制步骤
    
Delete:
    shell> rm /etc/systemd/system/customized.service    # 直接删除服务文件即可
    
    shell> systemctl revert customized.service      # 删除服务文件

Log:
    shell> journalctl -u service-name.service -b        # 查看指定服务的输出日志
                      -e                                # 直接跳到日志尾部
                      -f                                # follow
                      -x                                # 





