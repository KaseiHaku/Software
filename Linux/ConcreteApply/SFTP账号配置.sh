shell> useradd -s /sbin/nologin -p miniosyc -M -U miniosyc          # 创建无法 ssh 登陆的用户，及一个用户同名用户组  
shell> passwd miniosyc                                              # 创建密码
shell> chown root:root /root/k8s/outer/self/minio/data              # 该目录开始一直往上到系统根目录为止的目录拥有者都只能是 root
shell> chmod 755 /root                                              # 因为默认 /root 权限为 754
shell> chmod 755 /root/k8s/outer/self/minio/data                    # owner: rwx, group: r_x, other: r_x 

shell> vim /etc/ssh/sshd_config
#注释掉这行
#Subsystem      sftp    /usr/libexec/openssh/sftp-server        # 注释掉这行，这行表示所有可使用 ssh 的用户都可使用 SFTP
#                                                               # 但是这种方式有一个缺陷，就是用户在 SFTP 软件里面可以 cd / 从而看到系统所有文件
Subsystem       sftp    internal-sftp           # 指定使用 sftp 服务使用系统自带的 internal-sftp，如果不添加，用户无法通过 sftp 登录。

#添加在配置文件末尾
Match User minisyc      # 新的 Match Block。匹配用户，如果要匹配多个组，多个组之间用逗号分割
    X11Forwarding no                                    # 这两行，如果不希望该用户能使用端口转发的话就加上，否则删掉
    AllowTcpForwarding no
    PermitTTY no
    ForceCommand internal-sftp                          # 指定 sftp 命令

shell> systemctl restart sshd.service                   # 重启
shell> sftp -P 22 miniosyc@192.168.1.210                # 登陆
