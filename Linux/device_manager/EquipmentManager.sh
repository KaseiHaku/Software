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
