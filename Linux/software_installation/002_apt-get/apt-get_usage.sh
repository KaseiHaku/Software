################################ Concept
# 包名格式: [主版本号]:[次版本号]-[修订版本号][Debian 版本后缀]
#     主版本号：            表示软件的主要版本或重大更改。通常在软件进行重大更新或整体架构变化时增加。
#     次版本号：            表示次要更改或功能增强。通常在软件的小规模更改或功能增强时增加。
#     修订版本号：          表示错误修复或小的改进。在进行错误修复或小幅改进时增加。
#     Debian 版本后缀：     可选项，用于标识与 Debian 发行版相关的信息，如 +debXuY，其中 X 代表 Debian 发行版号，Y 代表 Debian 版本号。
#     
#     例如：libnginx-mod-rtmp/stable 1:1.2.2+dfsg-3 amd64        
#     主版本号=1     次版本号=1.2.2     修订版本号=    Debian 版本后缀=+dfsg-3   Arch=amd64
#



################################ 帮助
shell> apt --help
shell> apt-get --help
shell> apt              # tab tab 查看所有相关命令
shell> man apt.conf
shell> less /usr/share/doc/apt/examples/configure-index        # 查看所有 options


################################ APT
shell> apt -a list docker-ce            # 查看指定 pkg 的所有版本
shell> 


################################ Query 软件包查询
shell> apt list --installed                                     # 查询所有已安装的包

shell> apt-cache search '.*'                                    # 查询仓库中所有软件包
shell> apt-cache search package                                 # 搜索包
shell> apt-cache show package                                   # 获取包的相关信息，如说明、大小、版本等
shell> apt-cache showpkg package                                # 显示软件包信息，包括包的依赖关系，包的提供者， 
shell> apt-cache pkgnames                                       # 打印软件包列表中所有包的名字
shell> apt-cache dumpavail                                      # 打印软件包列表中所有包的简介信息
shell> apt-cache depends package                                # 了解使用依赖

shell> apt list --all-versions                                  # 列出指定 pkg 的所有版本
shell> apt-cache policy pkg                                     # 列出指定 pkg 的所有版本 
shell> apt-cache madison pkg                                    # 列出指定 pkg 的所有版本

# 查找包含 指定文件 的软件包，效果同 shell> yum provides *bin/less    
shell> apt-get install apt-file                                 # 先安装软件
shell> apt-file update                                          # 更新包文件信息
shell> apt-file -i find 'pattern'                               # -i 忽略大小写
                -x                                              # pattern 是 regexp，默认为 glob
                --substring-match                               # pattern 是 子串匹配，不是 regexp 和 glob
                -l                                              # 仅显示包名
                
                                       



################################ Install 软件包安装
shell> apt-get install packagename                              # 安装一个新的软件包
shell> apt-get install pkg=version                              # 安装指定版本的软件包
shell> apt-get install iputils-ping                                 # 安装 ping 命令




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





################################ 制作本地仓库
#### 在线服务器相关命令
shell> apt-get install apt-rdepends        
shell> apt-rdepends -p -f Depends,PreDepends,Conflicts,Replaces,Obsoletes -s Depends,PreDepends,Conflicts,Replaces,Obsoletes docker-ce
shell> apt-cache --recurse --no-recommends --no-suggests --no-conflicts --no-breaks --no-replaces --no-enhances depends docker-ce
shell> apt-get download $(apt-cache --recurse --no-recommends --no-suggests --no-conflicts --no-breaks --no-replaces --no-enhances depends docker-ce | grep -E '^[-_[:alnum:]]')    # 下载所有依赖


shell> mkdir /opt/localapt
shell> apt-get --install-suggests --download-only --dry-run --assume-yes --option=Dir::Cache::Archives=/opt/localapt reinstall docker-ce    # 下载所有依赖
shell> apt-get --install-suggests -d -s -y -o Dir::Cache::Archives=/opt/localapt reinstall docker-ce    # ditto
shell> apt-cache --recurse depends docker-ce

shell> apt-get install dpkg-dev
shell> dpkg-scanpackages . | gzip -9c > Packages.gz                 # 创建仓库信息; 解压并显示 shell> gzip -dc Packages.gz | less   
shell> tar -zcf localapt.tar.gz -C /opt/localapt .                  # 打包，然后将该包放到离线服务器上
#### 离线服务器相关命令
shell> mkdir /opt/localapt                                          # 创建本地 yum repo 目录
shell> tar -zxf localapt.tar.gz -C /opt/localapt
# shell> man sources.list
shell> cat <<-'EOF' >> /etc/apt/sources.list
deb [ trusted=yes, allow-insecure=yes ] file:/mnt/localpacks ./
EOF
shell> apt-get update
shell> apt-get install ansible                                       # 使用 离线软件源 安装软件
