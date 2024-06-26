# 磁盘基本概念
# 磁盘结构：一个磁盘由多个盘片构成，一个盘片有多个磁道，磁道之间组成一个个同心圆
# 柱面：每个磁片上相同半径的磁道，组成的一个圆柱型的表面
# 物理扇区(Physical Sector)：一个扇区是一个磁道上的一段区域，物理扇区是硬盘实际执行读写操作的最小单元，由硬盘的制造技术所造成的物理限制
shell> cat /sys/block/sda/queue/physical_block_size     # 查看 sda 硬盘的 物理扇区 的大小


# 逻辑扇区(Logical Sector)：是硬盘可以接受读写指令的最小操作单元
#         存在的主要原因是: 因为 OS 对大小为 512B 的扇区兼容性最好，对大小为 1024B 的扇区存在兼容性问题，所以硬盘制造商在硬盘内部直接抽象了一层出来给 OS 使用
shell> cat /sys/block/sda/queue/logical_block_size      # 查看 sda 硬盘的 逻辑扇区 的大小


# 分区(Partition)：将硬盘中一大片连续的 逻辑扇区 合并成一个 分区
# Linux 中分区的表现形式为 设备名+分区号，例如 sda1 表示 sda 这块磁盘的第一个分区
# 分区方式有两种：
#   MBR(dos, msdos):
#       主分区：最多 4 个主分区
#       扩展分区：最多一个，一个扩展分区占用一个主分区的位置，基于扩展分区可以创建 n 个逻辑分区
#       逻辑分区：Linux 最多支持 63 个 IDE 分区和 15 个 SCSI 分区
#       最多支持 2T 
#   GPT:
#       必须是 64bit 系统
#       必须在支持UEFI的硬件上才能使用
shell> fdisk        # @deprecated 
shell> parted       


# 格式化：对 分区 内的所有 逻辑扇区 进行规划，即：将 逻辑扇区 分组，每组为一 簇，
# 簇(Cluster)：一  簇 对应多个 逻辑扇区，是文件系统对 分区 读写的最小单位
shell> mkfs


# 物理扇区  逻辑扇区  簇 的关系
Cluster:                     |    0      |      1    |      2    |     3     |    4      |     5     |
Partition:                   |                                                                       |       
Logical Sector:     | 0| 1| 2| 3| 4| 5| 6| 7| 8| 9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|   
Physical Sector:    |    0      |      1    |     2     |      3    |    4      |   5       |    6      |
# 
# 由于上图 分区起始处 和 物理扇区 没有对齐，所以当读取 cluster0 时，硬盘实际要完整的读取 physical0 和 physical1 两个物理扇区，才能完成读取操作，极大的降低了性能
# 如何对齐？
#   物理扇区大小 / 逻辑扇区大小 = n 逻辑每物理；所以只要 分区起始位置为 n 的倍数，那么就是对齐的
 


# 磁盘在 Linu 中的表现形式
# Linux 所有设备都被抽象成 /dev 目录下的一个文件，
# IDE 设备的名称为 hd[a-z] 
# SATA、SCSI、SAS、USB 等设备的名称为 sd[a-z]








