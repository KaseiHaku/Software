################################## CentOS7 设备管理 ############################
# 相关文件
/etc/fstab														#所有挂载在系统上的文件系统
/dev/hd[a-d]													#IDE 硬盘 
/dev/sd[a-p]													#USB|SATA|SCSI 硬盘 
/dev/lp[0-2]													#25针 打印机 
/dev/usb/lp[0-15]												#USB 打印机 
/dev/usb/mouse[0-15]											#USB 鼠标 
/dev/mouse 														#当前的鼠标 
/dev/cdrom 														#当前CD/DVDROM 


# Linux 默认的文件描述符
/dev/stdin                       # 标准输入
/dev/stdout                      # 标准输出
/dev/stderr                      # 标准错误输出
/dev/null                        # 丢弃数据
/dev/zero                        # 是一个字符设备，会不断返回0值字节（\0）


# 查看所有连接到系统的设备
ls -al /dev                                       # 查看当前系统连接的所有设备，注意：虽然设备连接到系统，但是却没有被系统管理，需要挂载操作后才被能系统管理


# 把设备添加到系统，即被系统管理
mount -t ext4 -o rw /dev/cdrom /mnt/cdrom         # 添加设备到系统，挂载
      -t ntfs                                     # 标明被挂载设备的文件系统格式
              -o loop                             # 用来把一个文件当成硬盘分区挂载到系统上
              -o ro                               # 只读挂载
              -o rw                               # 读写挂载
              -o iocharset=gb2312                 # 指定挂载设备的字符集

             
# 把设备从系统中移除
umount /dev/cdrom                                # 卸载操作，也可以使用挂载目录：/mnt/cdrom


# 对设备进行操作
mkfs -t ext4 /dev/usb                             # 格式化操作，在设备上创建文件系统
fdisk /dev/hda                                    # 对/dev/hda设备进行分区操作
fdisk -l /dev/hda                                 # 查看指定磁盘的分区表
df -ih                                            # 查看已挂载磁盘的总容量、使用容量、剩余容量等


# 分区工具
parted help                 # 用于替代 fdisk 


# 创建 swap 文件 ###################
dd if=/dev/zero of=/tmp/newdisk bs=4k count=102400			# 用指定大小的块拷贝一个文件，并在拷贝的同时进行指定的转换
mkswap /tmp/newdisk											                # 格式化该文件
free -h														                      # 查看系统内存以及虚拟内存使用情况
swapon /tmp/newdisk											                # 启用swap文件
swapoff /tmp/newdisk											              # 关闭swap文件


# U 盘的使用 ########################
fdisk -l 														                    # 插入U盘前后各一次，比较第二次中新多出来的设备
cd /mnt
mkdir usb
mount -t vfat /dev/[多出来的设备] /mnt/usb 					    # vfat 是U盘的文件系统，不同的文件系统不同需要改
ls /mnt/usb 													                  # 查看U盘中的文件
umount /mnu/usb 												                # 卸载U盘


# 分区 ########################
shell> parted --align=none      # 为新创建的分区，设置  对齐 方式
                                # none: 使用磁盘类型允许的最小对齐
                                # cyl(cylinder, 柱面): 将分区对齐到柱面
                                # min: 将 逻辑分区表地址 与 磁盘上的实际物理块对齐，
                                # opt: 以 物理扇区 的倍数对齐


# 扩展 /var 分区 ########################
shell> # 虚拟机扩展磁盘大小
shell> lsblk -a                     # 列出所有块设备
shell> parted                       # 执行分区
shell> parted help                  # 查看 parted 帮助
shell> parted help unit             # 查看 unit 命令的帮助
shell> parted unit compact          # 调整 parted 中 输入 和 输出 的单位，compact 输入: MB, 输出: 压缩

(parted) print devices           # 查看所有硬盘
(parted) select /dev/sda         # 选择一个硬盘，后续操作都针对这个硬盘
(parted) print all               # 查看已分区信息
(parted) print free              # 查看未分区信息
(parted) unit s                  # 表示后续 输入 输出 默认单位都是 sector


# 设置分区 Label
(parted) mklable                # 创建新的分区 标签

# 获取 磁盘的 alignment(对齐) 参数，
# @trap sda 需要替换为实际的 设备名称
shell> cat /sys/block/sda/queue/physical_block_size         # 物理扇区：是硬盘实际执行读写操作的最小单元
shell> cat /sys/block/sda/queue/logical_block_size          # 逻辑扇区：是硬盘可以接受读写指令的最小操作单元
shell> cat /sys/block/sda/queue/optimal_io_size             # 最佳的 I/O 大小
shell> cat /sys/block/sda/queue/minimum_io_size             # 最小 I/O 大小
shell> cat /sys/block/sda/alignment_offset
# (optimal_io_size + alignment_offset) / physical_block_size    # 网上的计算公式，但是目前不适用自己的环境


# 执行 分区 操作
# (parted) mkpart primary xfs 1000B 10000B    # 创建分区    主分区    xfs文件系统    1k字节处开始     1w字节处结束
# (parted) mkpart primary xfs 0% 100%          # 当 optimal_io_size = 0 时，使用 0% 来自动获取最佳分区效果
(parted) mkpart primary xfs 536860137s 403GB
Warning: The resulting partition is not properly aligned for best performance: 536860137s % 2048s != 0s
Ignore/Cancel? Cancle

shell> expr 536860137 % 2048     # 计算出余数，表示 余 1513 个扇区
1513       
shell> expr 2048 - 1513         # 除数 减 余数 = 被除数 整除 需要补充的扇区数
535
shell> expr 536860137 + 535     # 得到能被 2048 整除 的 被除数
536860672
   
(parted) mkpart
Partition name?  []?                                                      
File system type?  [ext2]? xfs                                            
Start? 536860672s                # 以 可以被整除的被除数当作 分区的起始扇区，再次分区                                         
End? 403GB

# 查看新分区
(parted) print free 

# 检查分区是否对齐
(parted) align-check optimal 8     
(parted) quit       # 需要更新 /etc/fstab 文件才能开机自动挂载

# 格式化新的分区
shell> ls -l /lib/modules/$(uname -r)/kernel/fs     # 查看当前 内核 支持的文件系统
shell> mkfs -t xfs /dev/sda8            # 执行格式化

# 挂载
shell> mkdir /varbak                    # 创建挂在目录
shell> mount /dev/sdaNew /varbak        # 将新分区挂载到 /varbak 上，该指令有误，
shell> cp -a /var/* /varbak             # 复制内容到 新的分区中


# 查看 新分区的 UUID
shell> blkid                    
shell> ls -l /dev/disk/by-uuid
shell> lsblk -f
shell> hwinfo --block | grep by-uuid | awk '{print $3,$7}'

# 配置开机自动挂载
shell> vim /etc/fstab           # 将老的 /var 挂载的分区注释掉，并将 /var 添加到新分区上
shell> shutdown -h now          # 重启即可

# 删除掉原来 /var 挂在的分区
shell> parted
(parted) rm 6       # 6 为 老 var 挂载的分区
(parted) quit



# 查看设备块大小 ########################
shell> cat /proc/partitions
shell> blkid -o list 
shell> lsblk -f                           # 推荐
shell> fdisk -l                           # @deprecated 使用 parted 替代
parted> print list                        # Sector size (logical/physical): 512B/512B    逻辑扇区/物理扇区
shell> df -h

shell> stat -f /
shell> tune2fs -l /dev/sda1 | grep "Block size"        # 用于修改 ext? 文件系统的参数
shell> blockdev --getbsz /dev/sda2








