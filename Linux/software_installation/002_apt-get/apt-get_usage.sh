################################ Query 软件包查询
shell> apt-cache search all                                     # 查询仓库中所有软件包
shell> apt-cache search package                                 # 搜索包
shell> apt-cache show package                                   # 获取包的相关信息，如说明、大小、版本等
shell> apt-cache showpkg package                                # 显示软件包信息，包括包的依赖关系，包的提供者， 
shell> apt-cache pkgnames                                       # 打印软件包列表中所有包的名字
shell> apt-cache dumpavail                                      # 打印软件包列表中所有包的简介信息
shell> apt-cache depends package                                # 了解使用依赖



################################ Install 软件包安装
shell> apt-get install packagename                              # 安装一个新的软件包




################################ Remove 软件包删除、卸载
shell> apt-get remove packagename                               # 卸载一个已安装的软件包（保留配置文档）
shell> apt-get remove --purge packagename                       # 卸载一个已安装的软件包（删除配置文档）
shell> apt-get autoremove packagename                           # 删除包及其依赖的软件包
shell> apt-get autoremove --purge packagname                    # 删除包及其依赖的软件包+配置文件，比上面的要删除的彻底一点




################################ Update 软件包更新
shell> apt-get update
# 根据 /etc/apt/sources.list 和 /etc/apt/sources.list.d 中列出来的源的地址
# 下载最新的软件列表，更新本地软件包缓存信息（包含软件名，版本，校验值，依赖关系等）
# 具体下载文件在目录： /var/lib/apt/lists

shell> apt-get upgrade                                          # 只更新需要更新的包，不处理依赖关系
shell> apt-get dist-upgrade                                     # 根据更新后的包依赖关系，添加或者删除依赖包
# 下载最新的软件包，并替换系统上过时的软件
# 具体下载文件的保存目录为： /var/cache/apt/archives

################################ Clean 软件包清理、缓存备份等
shell> apt-get clean                                            # 清除已安装软件的备份软件包
shell> apt-get autoclean                                        # apt 卸载或者安装软件是会有备份，这个命令来删除您已卸载掉的软件的备份
