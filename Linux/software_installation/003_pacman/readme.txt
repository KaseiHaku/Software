相关配置文件及目录：
    /etc/pacman.conf
    /etc/pacman.d

帮助：
    shell> man pacman
    shell> man pacman.conf
    shell> pacman --help
    shell> pacman -Q --help

换源：
    shell> sudo pacman-mirrors -c China



常用：
    shell> pacman -Q            # 查询所有已安装
    shell> pacman -Qu           # 查询已安装并过期的包
    shell> pacman -Qs           # 查询本地已安装的包 

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

                  

    shell> pacman -U pkg1.tgz     # 更新指定包的指定版本

    shell> pacman -F            # 查看包所包含的文件
    
    shell> pacman -Qdtq                 # 查看 不需要的 包
    shell> pacman -R $(pacman -Qdtq)    # 清除不需要的包
    
