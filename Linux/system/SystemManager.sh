# CentOS7 系统介绍
# tty ：终端设备的统称，源于 teletypes
# pty(pseudo-tty) ：虚拟终端，远程登录中的概念，或者在 gnome 桌面环境中的终端也是 pty
# pts(pseudo-terminal slave) 是 pty 的实现方法，与 ptmx(pseudo-terminal master) 配合使用实现 pty
# CentOS7 中一共有 7 个 tty ，每个终端相互独立，1-6 是命令行终端，7 是 X-window 图形终端

# 查看 Linux 内核版本：
shell> cat /proc/version        
shell> uname -a

# 检查系统发行版本
shell> ls -al /etc/*release*        # 查看当前系统的发行版本
shell> sudo dmesg | grep Linux                 

# 常用命令
logout                                                      # 命令行终端登出
exit [stateValue]              # 退出当前 shell，退出代码 stateValue
Ctrl+Alt+F[1-7]                 # 切换终端
startx      # 启动图形界面


# 进入单用户模式 
     # 单用户模式概念：
        其实是一个安全模式下的内存系统，并不是平常使用的 linux 系统，
        shell> ls /sysroot/         # 查看我们正常系统中的文件
        shell> chroot /sysroot/     # 切换到正常系统中去
        shell> passwd root          # 可以修改 root 密码了
        shell> touch /.autorelabel  # 修改 root 密码后，必须执行该命令，不然会导致系统无法正常登陆，该命令让 selinux 重新标记文件
        shell> exec /sbin/init      # 退出单用户模式
        shell> reboot               # 重启方式退出单用户模式

    # GRUB 进入单用户模式
        按 ESC or Space or Shift 进去编辑模式
        找到 linux 开头的行，追加 init=/bin/bash 
        Ctrl+X 启动

   
    # 新版进单用户模式
    开机进入内核选项时，按 e 进入编辑
        找到 linux16 开头的行，按向右的方向键，定位到 ro， 把 ro 改成 "rw init=/sysroot/bin/sh"
        Ctrl+X，就进入单用户模式了，
    
    # 老版进单用户模式
    找到 linux16 开头并带有 ro 的行，删除 rhgb 和 quiet，并添加init=/bin/sh
    ctrl+x      # 启动
    touch /.autorelabel
    exec /sbin/init



# 定时执行命令 的命令
at                             # 在指定的时间执行某条命令
at -l # 显示待执行任务的列表
at -f cmd.txt # 指定包含具体指令的任务文件
at -q alarmClock  # 指定这次任务的名称叫 alarmClock
at -d alarmClock # 删除还未执行的任务
at -m # 任务执行完成后向指定用户发送 e-mail
at -c task1 # 查看 task1 的内容



# Linux 系统配置文件 ###########################
rc （run command) 表示脚本

/etc/rc.d/rc.sysinit                                            # 由init执行的第一个脚本，init 上电自启动进程 PID=1
/etc/inittab                                                    # 设置默认运行级别的配置文件
/etc/rc.d/rc                                                    # 根据指定的运行级别，调用对应运行级别目录下的脚本，
/etc/rc.d/rc[0-6].d/K90network	->/etc/rc.d/init.d/network      # 特定运行级别运行的脚本；K表示运行时关闭；90表示该脚本执行的顺序（从小到大执行）；先运行K带头的在运行S带头的
/etc/rc.d/init.d/                                               # 所有运行级别保存真实脚本的目录
/etc/rc.d/rc.local                                              # 启动时最后被执行的脚本文件














