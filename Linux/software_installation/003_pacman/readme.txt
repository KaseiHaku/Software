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
    shell> pacman -Sy           # 更新仓库
    shell> pacman -Sl           # 列出仓库中所有的包
    shell> pacman -Ss string    # 查询包
    shell> pacman -S package    # 安装包
    
    
    shell> pacman -F            # 查看包所包含的文件
