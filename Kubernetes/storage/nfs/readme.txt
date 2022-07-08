################################ NFS 服务端配置 ################################
# 安装
shell> yum install nfs-utils

# 检查
shell> systemctl enable rpcbind     # 该包是 nfs-utils 包的依赖
shell> systemctl enable nfs

shell> systemctl start rpcbind
shell> systemctl start nfs

# 关闭防火墙
shell> systemctl stop firewalld

# 创建共享目录
shell> mkdir /opt/nfs/
shell> chmod 755 /opt/nfs/

# 添加配置文件
# /opt/nfs/             共享目录位置
# 192.168.0.0/24        客户端 IP 范围，* 代表所有，即没有限制。
# rw                    权限设置，可读可写
# sync                  同步共享目录
# no_root_squash        可以使用 root 授权
# no_all_squash         可以使用普通用户授权
shell> cat <<EOF | tee /etc/exports
/opt/nfs/     192.168.1.0/24(rw,sync,no_root_squash,no_all_squash,insecure)
EOF

# 重启 nfs 服务
shell> systemctl restart nfs

# 检查本地的共享目录
shell> showmount -e localhost


################################ NFS 客户端配置 ################################
# 安装
shell> yum install nfs-utils

# 启动
shell> systemctl enable rpcbind
shell> systemctl start rpcbind

# 查看服务端的共享目录
shell> showmount -e 192.168.1.210

# 在客户端创建 共享目录的 挂载目录
shell> mkdir /opt/nfs

# 挂载
shell> mount -t nfs 192.168.1.210:/opt/nfs   /opt/nfs
shell> mount | grep /opt/nfs        # 检查挂载是否成功

# 测试 nfs
shell> cd /opt/nfs
shell> echo aaa > a.txt
shell> ll /opt/nfs    # NFS 服务端查看文件是否创建

# 配置客户端自动挂载
shell> echo '192.168.1.210:/opt/nfs     /opt/nfs   nfs  defaults    0   0' >> /etc/fstab
shell> systemctl daemon-reload    # 使修改生效



