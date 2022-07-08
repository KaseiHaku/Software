0. 相关文件目录简介 
    /etc/yum.conf           # 当前系统 yum 的全局配置文件，对所有仓库生效，可以把 yum 源配置在这里，但是建议配置在 /etc/yum.repos.d 目录下
    /etc/yum.repos.d        # 第三方 yum 源配置文件存放目录，该目录下每一个 .repo 文件都是一个 yum 远程仓库的配置文件 


1. 查看当前系统信息
    shell> rpm -qa|grep centos-release

    centos-release-7-4.1708.el7.centos.x86_64
    $release    7.4.1708                    # 版本
    $basearch   x86_64                      # 系统架构信息
    
2. 备份原有的 yum 源
    shell> cd /etc/yum.repo.d
    shell> mv CentOs-Base.repo CentOs-Base.repo.bak     # 备份文件，该命令只备份一个，需要备份原有的所有文件，当然也可以直接备份目录
  
3. 下载你想要的第三方 yum 源的 .repo 文件到 /etc/yum.repo.d 目录下
    http://mirrors.aliyun.com/repo/Centos-7.repo            # 阿里 yum 源的 .repo 配置文件下载地址
    http://mirrors.163.com/.help/CentOS7-Base-163.repo      # 网易 yum 源的...

4. 修改下载 .repo 文件（注意有些需要改，有些不需要改）
    网易 yum 源修改
        用 7.4.1708 和 x86_64 两个参数替换 .repo 文件中的 $releaserver 和 $basearch 这两个值

5. 生效处理
    shell> yum clean all        # 清理原先的 yum 缓存
    shell> yum makecache        # 创建新的缓存

6. 检查新配置是否生效
    shell> yum list | grep vim
    
    


