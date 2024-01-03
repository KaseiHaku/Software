# 预备知识
    linux 所有硬件都虚拟为一个文件，并保存在 /dev 目录下
    
    linux 硬件分为三类： 字符设备、块设备、网络设备
    
    linux 系统唯一标识一个硬件的方法：
        设备文件名 + 主、从设备号
        /dev/hd[a-d]: IDE硬盘。       
        /dev/sd[a-p]: SCSI/SATA/USB硬盘或U盘。
        /dev/lp[0-2]: 25针接口打印机。       
        /dev/mouse: 当前鼠标。
        /dev/cdrom: 当前CD/DVD ROM
        /dev/usb/mouse[0-15]: USB接口鼠标。
  
#### Summary
# DMI 是什么：
#    是 "Desktop Management Interface"（桌面管理接口）的缩写。
#    它是一种由系统固件（如 BIOS 或 UEFI）提供的标准化接口，用于收集和提供关于计算机系统硬件配置的信息。
#    主板信息存储在 /sys/class/dmi/id/ 目录下的各个文件中，以下是其中一些常见的文件及其对应的主板信息：
#        board_vendor：主板制造商（Vendor）信息。
#        board_name：主板型号（Name）信息。
#        board_version：主板版本（Version）信息。
#        bios_vendor：BIOS 制造商信息。
#        bios_version：BIOS 版本信息。
#        bios_date：BIOS 发布日期信息。

shell> dmidecode         # 用于获取系统的硬件信息，包括 BIOS、主板、内存、处理器等，@trap 如果安装完找不到命令，直接 shell> /usr/sbin/dmidecode 调用
shell> lshw -short      # 与 dmidecode 不同，lshw 不仅仅读取 DMI 数据，还通过其他机制（如/sys 文件系统）获取硬件信息 

# 与 dmidecode 和 lshw 不同，
# hwinfo 可以通过多种方式获取硬件信息，包括读取 DMI 数据、解析 /proc 和 /sys 文件系统中的信息，以及与设备进行交互
shell> hwinfo           
                        


#### Baseboard
shell> dmidecode -t baseboard        # 查看主板信息

#### Hard Disk
    分区方式：
        其中 BIOS 和 UEFI 都是最最基础的硬件操作系统
        其中 MBR 和 GPT 是分区格式，MBR 最多能分 4 个，GPT 最多 128 个
        BIOS + MBR: Deprecated
        UEFI + GPT:       
        
    文件系统格式：
        Windows: FAT(Deprecated), NTFS
        Linux: Ext4, XFS(Trending)

    shell> less /proc/partitions    # 查看硬盘分区信息
    shell> lsblk -a     # 查看所有块设备    
    shell> df -ahT
    
    shell> fdisk -l     # 分区工具，适用于 MBR 分区
    shell> gdisk -l     # 分区工具，适用于 GPT 分区
    shell> parted -l    # 分区工具，
    
    
    信息查看:
        shell> iotop            # 进程级别 IO 监控
        shell> sar              # 最全面
        shell> iostat           # 系统级别的 IO 监控
        shell> vmstat 
            bi      block-in    块设备每秒接收的块数量，这里的块设备是指系统上所有的磁盘和其他块设备
            bo      block-out   块设备每秒发送的块数量，例如我们读取文件，bo 就要大于0
            @caveat bi 和 bo 一般都要接近 0，不然就是 IO 过于频繁，需要调整
    性能测试:
        shell> dd 
        shell> fio              # IO 压测工具 
    
#### Memory 内存
    shell> dmidecode -t memory    # 查看内存条信息，@trap 如果条数超过物理内存条，那么可能是 虚拟内存模块，这些模块不会显示 Size 
    shell> less /proc/meminfo   # 查看内存信息      
    shell> free -h -s 1     # 查看内存使用情况，-h 人类可读模式， 1秒输出一次
    
#### CPU
    # 总核数 = 物理 CPU 个数 X 每颗物理 CPU 的核数 
    # 总逻辑 CPU 数 = 物理CPU个数 X 每颗物理 CPU 的核数 X 超线程数
    shell> less /proc/cpuinfo       # 直接查看文件方式：查看 CPU 信息
    
    shell> cat /proc/cpuinfo| grep "physical id"| sort| uniq| wc -l     # 查看物理 CPU 个数
    shell> cat /proc/cpuinfo| grep "cpu cores"| uniq       # # 查看每个物理 CPU 中 core 的个数(即核数)
    shell> cat /proc/cpuinfo| grep "processor"| wc -l      # 查看逻辑 CPU 的个数
    
    shell> lscpu            # 命令行方式：查看 cpu 信息
    


#### USB
    shell> lsusb            # 查看 USB 接口的设备信息

#### PCI
    shell> lspci            # 查看所有在 PCI 总线上的设备

#### SCSI
    shell> lsscsi           # 查看 SCSI 控制器设备的信息，如果没有硬件，则不返回信息

