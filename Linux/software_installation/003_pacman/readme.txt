相关配置文件及目录：
    /etc/pacman.conf
    /etc/pacman.d

帮助：
    shell> man pacman
    shell> man pacman.conf
    shell> pacman --help
    shell> pacman -Q --help

换源：
    shell> sudo pacman-mirrors -c China -m rank
    shell> vim /etc/pacman.d/mirrorlist            # 删除所有不要的 "Server =" 行
    shell> sudo pacman -Syu                        # 滚动更新系统


常用：
    shell> pacman -Q            # 查询所有已安装
    shell> pacman -Qd           # 列出所有作为 依赖项 安装的 pkg
    shell> pacman -Qdtq         # 查看 不需要的 依赖项
    shell> pacman -Qe           # 列出所有作为 依赖 root 安装的 pkg，即: 主动安装的软件，类似 webpack 的 entry
    shell> pacman -Qg           # 列出所有 grouped packages
    shell> pacman -Ql pkg       # 查询指定 pkg 中包含哪些文件
    shell> pacman -Qm           # 查询不在 sync database 中的 pkg
    shell> pacman -Qo /path/to/file    # 查询当前 file 是哪个 pkg 下的
    shell> pacman -Qt           # 列出所有当前已安装的 pkg 都不 直接需要 或 选项需要 的 pkg
    shell> pacman -Qs regexp    # 查询本地已安装的包 
    shell> pacman -Qu           # 查询已安装并过期的包


    shell> pacman -S pkg1 pkg2   # 只更新指定的软件包
                  -y             # 更新本地包数据库
                  -yy            # 更新包，包括已经被忽略的包
                  -l             # 列出仓库中所有的包
                  -w             # 只下载包，但是不安装和升级
                  -u             # 更新所有可更新的软件包，在执行 shell> pacman -Su 命令之前，建议先备份系统和数据，以防止出现不可预料的问题
                  -uu            # 允许降级
                  --needed       # 不要重装已经是最新的包 
                  -c             # 清除老包
                  -cc            # 清除所有包
                  -s             # 查询远程仓库
    shell> pacman -Syu --noconfirm        # 更新所有更新，并且不需要每个确认

                  

    shell> pacman -U pkg1.tgz     # 更新指定包的指定版本

    shell> pacman -F            # 查看包所包含的文件
    
    
    shell> pacman -R $(pacman -Qdtq)    # 清除不需要的包
    
