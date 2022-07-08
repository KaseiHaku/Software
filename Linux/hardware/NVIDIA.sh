1. 关闭 BIOS secure boot 
    如果电脑的 BIOS 采用的是 UEFI firmware （UEFI 固件），那么安装之前一定要进入 BIOS 关闭 secure boot

2. 关闭 Ubuntu 自带的 Nouveau 驱动，因为跟 英伟达 公司的显卡兼容性不好   
    shell> vim /boot/grub/grub.cfg
    在文本中搜索 quiet slash 然后添加 acpi_osi=linux nomodeset，保存文本即可。

3. 查看自己 显卡 的型号
    shell> lshw -c display      # 查看显卡型号，找到 product： GF119M [GeForce 610M]

4. 官网下载对应型号的驱动

5. 关闭图形界面
    shell> telinit 3
    
6. 安装驱动
    shell> bash NVIDIA-Linux-x86_64-384.111.bin # 安装文件也可以是 .sh 结尾的

7. 重启
    shell> reboot
    