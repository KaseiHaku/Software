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

# 仓库管理
shell> yum -y install yum-utils                                         # 安装必备插件
shell> yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo    # 添加 yum 源仓库
shell> yum-config-manager --add-repo=file:///opt/localyum           # 添加本地目录作为 yum 源
shell> yum-config-manager --setopt=option=value                     # 全局配置 等价于 /etc/yum.conf 中配置，临时
shell> yum-config-manager --save --setopt=option=value              # 同上，但是将配置写入 /etc/yum.conf
shell> yum-config-manager --setopt=<repoid>.option=value            # 针对 repoid 仓库的配置，repoid 可以包含通配符
shell> yum-config-manager --enable \*           # 启用所有仓库
shell> yum-config-manager --disable \*          # 停用所有仓库


shell> yum-config-manager --setopt=skip_if_unavailable=true            # 运行时，如果仓库不可用则跳过

# 制作本地仓库
#### 在线服务器相关命令
shell> yum install -y createrepo
shell> repotrack --download_path=/opt/localyum -n ansible           # 下载 ansible 全量依赖包, -n 切换是否下载非最新的 rpm，默认最新的，加了就下载所有的
shell> createrepo /opt/localyum                                     # 创建仓库基本信息
shell> tar -zcf localyum.tar.gz /opt/localyum/*                     # 打包，然后将该包放到离线服务器上
#### 离线服务器相关命令
shell> mkdir /opt/localyum                                          # 创建本地 yum repo 目录
shell> tar -zxf localyum.tar.gz -C /opt/localyum                    
shell> yum-config-manager --add-repo=file:///opt/localyum           # 添加本地目录作为 yum 源
shell> yum-config-manager --save --setopt=opt_localyum.gpgcheck=0   # 0 表示关闭 gpg 校验；1 表示启用 gpg 校验
shell> vim /etc/yum.repo.d/opt_localyum.repo                        # gpgcheck=0 
shell> yum-config-manager --disable base extras updates             # 一般离线服务器需要执行这条命令，关闭原有仓库
shell> yum -y install ansible                                       # 使用本地仓库安装 ansible


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


# 离线安装
shell> yumdownloader --resolve --destdir=/tmp ansible                   # 下载 ansible，并解析依赖，并同时下载当前系统中没有的依赖
shell> repotrack --download_path=/tmp -n ansible                        # 下载 ansible 全量依赖包, -n 切换是否下载非最新的 rpm，默认最新的，加了就下载所有的
shell> yum --nogpgcheck localinstall a.rpm b.rpm c.rpm                  # 需要同时安装程序包所有的依赖项目，否则还是会尝试联网去下载缺少的依赖项目
                                                                        # --nogpgcheck  不让yum对程序包进行GPG验证
shell> yum localinstall xxx.rpm bbb.rpm                                 # 用 yum 安装已经下载的 rpm 包，让 yum 解析依赖关系
                                                                        # @trap 如果依赖包也是离线安装的，需要一次性写到一条命令里面
                                                                        


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
