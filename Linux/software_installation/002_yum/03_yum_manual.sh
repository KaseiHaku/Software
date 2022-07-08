# yum 安装：安装的其实还是 rpm 软件包，只是自动解决依赖关系，像 maven； 所以 yum 安装的软件还是能用 rpm 命令管理
# 使用该方式需先确保两个条件，1： yum 软件包自身已经安装   2： yum 源已经配置完成

# 帮助
shell> yum help
shell> yum help erase       # 查看子命令帮助


# 查看
shell> yum info package                                                 # 查看软件包的信息
shell> yum info yum                                                     # 查看 yum 自己的信息

shell> yum search str                                                   # 查找 软件包 描述中包含指定字符串的 软件包
shell> yum provides *bin/less                                           # 查找包含 指定文件 的软件包

shell> yum list                                                         # 查看 yum 源中的所有软件包
shell> yum --showduplicates list                                        # 查看仓库中一个包的所有版本
shell> yum list installed                                               # 列出所有采用 yum 安装的软件
shell> yum list extras                                                  # 列出已安装但不在yum源中的软件（本地）

shell> yum group list                                                   # 查看 yum 源中的所有软件组

# 安装
shell> yum install *.rpm                                                # 安装软件包
shell> yum groupinstall "GNOME Desktop"                                 # 安装软件组
shell> yum localinstall google-chrome-stable_current_x86_64.rpm         # 用 yum 安装已经下载的 rpm 包，让 yum 解析依赖关系


# 更新
shell> yum list updates                                                 # 列出所有可更新的包（yum源）
shell> yum check-update                                                 # 检查可更新的程序（本地）

shell> yum update *.rpm                                              # 更新程序包
shell> yum groupupdate "GNOME Desktop"                               # 更新程序组

shell> yum update                                                       # 升级所有包，改变软件设置和系统设置，系统版本内核都升级
shell> yum upgrade                                                   # 升级所有包，不改变软件设置和系统设置，系统版本升级，内核不改变
shell> yum downgrade                                                    # 降级


# 卸载
shell> yum erase *.rpm                                              # 卸载一个软件
shell> yum groupremove "GNOME Desktop"						        # 卸载一个程序组


# 其他操作
shell> yum clean all                                                    # 清除缓存
shell> yum makecache                                                    # 创建新的缓存
