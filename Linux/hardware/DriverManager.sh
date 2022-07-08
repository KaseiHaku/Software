################################## CentOS7 驱动管理 ############################
lspci     # 列出 pci 总线上的所有设备



# 安装网卡驱动 #########################################
# 1、查看系统内核版本
uname -r    
# 2、检查系统中是否安装下列包，由于编译需要用到内核的源代码包和编译程序gcc.所以如果没有的话,要先装.
rpm -qa | grep kernel
rpm -qa | grep gcc

# 3、驱动程序编辑及安装
官网下载驱动 xxx.tar.gz
把这个文件复制到 /usr/src 目录下
cd /usr/src
tar -zxvf xxx.tar.gz
cd ./xxx/src
make # 编译驱动程序源代码
make install  # 安装驱动程序
将驱动程序生成的 *.o 文件复制到 /lib/modules/3.10.0-693.el7.x86_64/kernel/drives/net 下
depmod -a       # 加载驱动程序
modprobe xxx  # 探测驱动程序
lsmod  # 查看已经加载的所有驱动程序，如果有 xxx 则表明安装成功


                           



