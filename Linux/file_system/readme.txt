/******************************* 文件目录结构及作用介绍：FHS 标准定义的目录 *************************************************************/
# 必须独立的分区
/boot                                   # 启动时相关的文件保存目录

# 不可与 / 目录挂载在不同分区的目录；
/bin        -> /usr/bin                 # 存放最经常使用的命令，为 /usr/bin 的软链接
/sbin       -> /usr/sbin                # root 用户才能使用的命令，为 /usr/sbin 的软链接，sudo 命令执行的命令都在该目录下
/lib        -> /usr/lib                 # 32位依赖库
/lib64      -> /usr/lib64               # 64位依赖库

/dev                                    # 设备文件保存目录
/etc                                    # 配置文件保存目录


# 没必要跟 / 目录挂载在不同分区的目录
/media                                  # 挂载 DVD 等东西
/mnt                                    # 临时额外挂载的文件系统目录，跟 /media 类似，是最早的统一挂载目录
/root                                   # root 用户家目录
/sys                                    # 虚拟文件系统，存放比 /proc 中更核心的数据
/proc                                   # 虚拟文件系统，其实是对内存的虚拟，将内存虚拟为硬盘文件系统，方便访问
/run                                    # 替代 /var/run
/lost+found                             # 遭遇意外宕机，存放找回数据的目录
/tmp                                    # 程序运行时，临时生成文件保存目录，甚至建议关机自动清除

# 最好跟 / 目录挂载在不同分区的目录
/home                                   # 普通用户家目录

/usr                                    # Unix Software Resource 的缩写，系统级软件资源存放目录，C:/Windows/
/usr/local                              # 用户级软件资源存放目录，C:/Progrem Files/ ；用户自己编译的软件默认会安装到这个目录下
/opt                                    # 用于安装那些独立运行的软件，即不需要对其他软件提供 lib 的软件，D:/Software

/var                                    # 经常变动的数据存放目录

/srv                                    # 网络服务所需要的文件存放目录，比如 Web 服务的 HTML 文件，应该放在 /srv/Web 目录下


/******************************* 常用分区方案 *************************************************************/
硬盘大小 256G
    方案一：
        /boot/efi           200M        xfs            当固件为 UEFI 时，必须存在
        /biosboot           2M          xfs            硬盘采用 GPT 分区，而固件为 BIOS 时，必须存在
        /boot               512M        xfs            包含引导系统所需的静态文件，需要在硬盘第一个分区
        /                   64G         xfs            根分区
        swap                16G         linuxswap      用于内存交换，16G 以上等于内存，否则两倍于内存 
        /opt                128G        xfs            测试开发等需要安装的软件比较多时，分大点
        /home               64G         xfs            多用户环境时，分大点
        /tmp                4G          xfs            运行高负载应用时，分大点
        /var                4G          xfs            随着系统的使用，该目录会越来越大，建议分大点，以上目录独立挂载，其他全部挂载在 /var 目录下
        
        
    方案二(推荐)：GUID Partition Table(GPT)
        bios-grub           64M        xfs        
        /boot               512M       xfs             包含引导系统所需的静态文件，需要在硬盘第一个分区
        /                   64G        xfs             根分区
        /opt                64G        xfs             软件盘 or 数据盘
        /home               64G        xfs             桌面系统，需要分大点
        swap                16G        linuxswap       >=512M, 内存小于 16G，等于两倍内存大小，内存大于 16G 等于内存大小
        /var                ---        xfs             以上目录独立挂载，其他全部挂载在 /var 目录下

    方案二(推荐 512G)：GUID Partition Table(GPT) 
        bios-grub           64M        xfs         
        /boot               512M       xfs             包含引导系统所需的静态文件，需要在硬盘第一个分区
        /                   96G        xfs             根分区
        /opt                160G       xfs              软件盘 or 数据盘
        /home               96G        xfs             桌面系统，需要分大点
        swap                32G        linuxswap       >=512M, 内存小于 16G，等于两倍内存大小，内存大于 16G 等于内存大小
        /var                ---        xfs             以上目录独立挂载，其他全部挂载在 /var 目录下


    方案三(Docker)：GUID Partition Table(GPT)
        bios-grub           64M        xfs         
        /boot               512M       xfs             包含引导系统所需的静态文件，需要在硬盘第一个分区
        /                   64G        xfs             根分区
        /opt                96G        xfs             软件盘 or 数据盘；以该顺序分区，后期 opt 可以吞了 home 和 swap
        /home               16G        xfs  
        swap                16G        linuxswap       >=512M, 内存小于 16G，等于两倍内存大小，内存大于 16G 等于内存大小
        /var                ---        xfs             以上目录独立挂载，其他全部挂载在 /var 目录下
    
        

/******************************* 文件系统类型 *************************************************************/
shell> ll /lib/modules/$(uname -r)/kernel/fs        # 查看当前内核支持的所有文件系统
ext4:   应用范围广
xfs:    新

tmpfs: 是一种虚拟内存文件系统，而不是块设备。是基于内存的文件系统，创建时不需要使用 mkfs 等初始化
       它最大的特点就是它的存储空间在 VM(virtual memory)，VM是由linux内核里面的vm子系统管理的。
       linux 下面 VM = RM(Real Memory) + swap

/******************************* 文件类型介绍 *************************************************************/
_rwxrwxrwx              # _ 普通文件
drwxrwxrwx              # d 目录； r=可以查看该目录的内容; w=可以新增，删除，修改，移动文件； x=可以cd进入该目录； 坑: 如果目录没有 w 权限，即使目录中的文件有 w 权限也没用
lrwxrwxrwx              # l 软链接
srwxrwxrwx              # s 套接字，伪文件，不占磁盘空间
brwxrwxrwx              # b 块设备，伪文件，不占磁盘空间
crwxrwxrwx              # c 字符设备，伪文件，不占磁盘空间
prwxrwxrwx              # p 管道，伪文件，不占磁盘空间

/******************************* 文件系统相关文件 *************************************************************/
shell> vim /etc/fstab           # 用于配置 系统启动 时要 挂载 的 文件系统
shell> vim /etc/mtab            # 记录当前系统 已经挂载的 文件系统

shell> blkid            # 查看 /etc/fstab 中 UUID 对应的 分区
shell> df -h            # 查看分区









