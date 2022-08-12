# yum 安装：安装的其实还是 rpm 软件包，只是自动解决依赖关系，像 maven； 所以 yum 安装的软件还是能用 rpm 命令管理
# 使用该方式需先确保两个条件，1： yum 软件包自身已经安装   2： yum 源已经配置完成

# 包名格式: name=包名, arch=架构, ver=版本, rel=针对不同 OS 的发行号, epoch=时代/纪元/时期
#   name
#   name.arch
#   name-ver
#   name-ver-rel
#   name-ver-rel.arch
#   name-epoch:ver-rel.arch
#   epoch:name-ver-rel.arch





# 帮助
shell> yum help
shell> yum help erase       # 查看子命令帮助


# 查看
shell> yum info package                                                 # 查看软件包的信息
shell> yum info yum                                                     # 查看 yum 自己的信息

shell> yum search str                                                   # 查找 软件包 描述中包含指定字符串的 软件包
shell> yum provides *bin/less                                           # 查找包含 指定文件 的软件包

shell> yum list                                                         # 查看 yum 源中的所有软件包
                                                                        # list 显示格式
                                                                        #   name.arch       [epoch:]ver-rel     repo
                                                                        
                                                                        
                                                                        
                                                                        
shell> yum --showduplicates list                                        # 查看仓库中一个包的所有版本
shell> yum list installed                                               # 列出所有采用 yum 安装的软件
shell> yum list extras                                                  # 列出已安装但不在yum源中的软件（本地）

shell> yum group list                                                   # 查看 yum 源中的所有软件组
shell> yum deplist kubeadm                                              # 查看包依赖

# 安装
shell> yum install -y {epock}:{package name}-{version}-{release}.{arch} # 完整格式
shell> yum install -y {package name}-{version}-{release}                # 常用

shell> yum install *.rpm                                                # 安装软件包
shell> yum groupinstall "GNOME Desktop"                                 # 安装软件组
shell> yum localinstall google-chrome-stable_current_x86_64.rpm         # 用 yum 安装已经下载的 rpm 包，让 yum 解析依赖关系

# 离线安装
shell> yum -y install yum-utils
shell> yumdownloader --resolve --destdir=/tmp ansible                   # 下载 ansible，并解析依赖，并同时下载当前系统中没有的依赖
shell> repotrack --download_path=/tmp -n ansible                        # 下载 ansible 全量依赖包, -n 切换是否下载非最新的 rpm，默认最新的，加了就下载所有的
shell> yum --nogpgcheck localinstall a.rpm b.rpm c.rpm                  # 需要同时安装程序包所有的依赖项目，否则还是会尝试联网去下载缺少的依赖项目
                                                                        # --nogpgcheck  不让yum对程序包进行GPG验证
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
