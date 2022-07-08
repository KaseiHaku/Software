################################ FAQ ################################
shell> journalctl -xb               # 查看启动报错日志，并搜索相关报错，例如: fail to mount ...; 找到哪个目录挂载失败
shell> lsblk                        # 找到 挂载失败目录 对应的 设备
shell> xfs_repair -vL /dev/sda2     # 修复
shell> shutdown -r +0               # 重启
