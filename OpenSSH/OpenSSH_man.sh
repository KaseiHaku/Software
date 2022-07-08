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

