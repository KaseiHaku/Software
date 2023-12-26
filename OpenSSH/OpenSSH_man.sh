1. 安装 OpenSSH
    shell> apt-get insatll openssh-server

2. 配置 root 用户远程登录
    shell> vim /etc/ssh/ssh_config
    添加或修改一行：
    PermitRootLogin prohibit-password 改成 PermitRootLogin yes
    保存
    
    shell> vim /etc/ssh/sshd_config
    添加或修改一行：
    PermitRootLogin prohibit-password 改成 PermitRootLogin yes
    保存

3. 重启服务
    shell> systemctl restart sshd.service


使主机 B 信任 主机 A，即：A 可以无密码登录 B:
    shellB> grep -i 'PubkeyAuthentication' /etc/ssh/sshd_config        # 检查是否为 yes，不然不能使用该方式登录

    shellA> ssh-keygen -t ecdsa            # 一路回车
    shellA> # 复制 pubkey 放到 主机 B 的  ~/.ssh/authorized_keys    中即可
    shellA> ssh-add            # 把刚生成的 pvtkey 添加到 ssh 认证中

添加了 ssh key 后，仍然强制使用 password 登录
    shell> ssh -l root -p 22 -o PreferredAuthentications=password 1.2.3.4
