################################## CentOS7 驱动管理 ############################
lspci     # 列出 pci 总线上的所有设备

compgen -c | grep mod        # 查看所有可用命令中包含 mod 的命令
lsmod        # 显示当前已加载的内核模块列表
modinfo      # 显示指定内核模块的详细信息
insmod       # 手动加载指定的内核模块
rmmod        # 卸载指定的内核模块
modprobe     # 自动加载模块及其相关依赖。它还可以根据配置文件（如 /etc/modprobe.d/ 目录中的文件）进行自定义
depmod       # 生成内核模块的依赖关系并更新模块依赖的索引文件



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


                           



