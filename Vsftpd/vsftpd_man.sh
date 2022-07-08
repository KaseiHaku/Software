0. 预备知识
    FTP 传输模式： {
        主动模式：{
            客户端从任意端口 n 连接到 FTP 服务的 21 号端口，
            客户端发送接收端口 n+1 到 FTP 服务器，并开始监听自己的 n+1 端口（通过发送 FTP 命令： port n+1 执行此步骤）
            FTP 服务器以 20 号端口连接到客户端指定的 n+1 端口
        }
        被动模式：{
            客户端从任意端口 n 连接到 FTP 服务的 21 号端口，
            客户端提交 PASV 命令，
            服务器开启任意一个端口 m , 并发送 port m 命令给客户端
            客户端从本地 n+1 端口到服务器的 m 端口的连接用来传递数据 
        }
    }
    

1. 安装 vsftpd
    shell> apt-get install vaftpd

2. 传输模式配置
    shell> vim /etc/vsftpd.conf
    查看当前目录下的 vsftpd.conf 文件

3. 用户访问模式配置
    # 匿名用户配置
    匿名用户默认访问的FTP服务器端路径为： /var/ftp/pub
    shell> vim /etc/vsftpd.conf
    添加或修改以下配置：
    anonymous_enable=YES                 # 开启匿名用户
    anon_upload_enable=YES               # 允许匿名用户上传文件；
    anon_mkdir_write_enable=YES          # 允许匿名用户创建目录；
    anon_other_write_enable=YES          # 允许匿名用户其他写入权限。
    另外默认Vsftpd匿名用户有两个：anonymous、ftp，所以匿名用户如果需要上传文件、删除及修改等权限，需要ftp用户对/var/ftp/pub目录有写入权限
    shell> chown -R ftp /var/ftp/pub


    # 系统用户配置：
    添加系统用户，已经存在的用户不用添加
    shell> useradd ftpuser
    shell> passwd ftpuser
    
    修改配置文件
    listen=NO
    listen_ipv6=YES
    anonymous_enable=NO     # 禁止匿名用户登录
    local_enable=YES
    write_enable=YES
    local_umask=022
    dirmessage_enable=YES
    use_localtime=YES
    xferlog_enable=YES
    connect_from_port_20=YES
    chroot_local_user=YES
    secure_chroot_dir=/var/run/vsftpd/empty
    pam_service_name=vsftpd
    rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem
    rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
    ssl_enable=NO
    pasv_enable=Yes
    pasv_min_port=10000
    pasv_max_port=10100
    allow_writeable_chroot=YES
    

    
    shell> vim /etc/vsftpd/user_list
    添加如下一行（一个用户一行）
    ftpuser
    
    
    # 虚拟用户配置
    虚拟用户是没有实际的真实系统用户，而是通过映射到其中一个真实用户以及设置相应的权限来实现访问验证，虚拟用户不能登录Linux系统
    因为需要虚拟用户需要映射到一个真实用户，所以我们需要新建一个真实用户，即 宿主用户
    shell> useradd virtual_ftp_user -s /sbin/nologin  # 新建一个真实用户，并设置不能登录 shell
    
    修改配置文件
    anonymous_enable=NO  #设定不允许匿名访问
    anon_upload_enable=NO  #禁止匿名用户上传。
    anon_mkdir_write_enable=NO  #禁止匿名用户建立目录。
    
    local_enable=YES  #设定本地用户可以访问。注意：主要是为虚拟宿主用户，如果该项目设定为NO那么所有虚拟用户将无法访问。
    write_enable=YES  #设定可以进行写操作。
    local_umask=022  #设定上传后文件的权限掩码。
    
    dirmessage_enable=YES  #设定开启目录标语功能。
    xferlog_enable=YES  #设定开启日志记录功能。
    connect_from_port_20=YES #设定端口20进行数据连接。(主动模式)
    chown_uploads=NO  #设定禁止上传文件更改宿主。
    #chown_username=whoever
    xferlog_file=/var/log/xferlog
    #设定Vsftpd的服务日志保存路径。注意，该文件默认不存在。必须要手动touch出来，并且由于这里更改了Vsftpd的服务宿主用户为手动建立的Vsftpd。必须注意给与该用户对日志的写入权限，否则服务将启动失败。
    xferlog_std_format=YES #设定日志使用标准的记录格式。
    #idle_session_timeout=600 #设定空闲连接超时时间，单位为秒，这里默认。
    #data_connection_timeout=120 #设定空闲连接超时时间，单位为秒，这里默认
    #nopriv_user=ftptest

    async_abor_enable=YES  #设定支持异步传输功能。

    ascii_upload_enable=YES
    ascii_download_enable=YES  #设定支持ASCII模式的上传和下载功能。

    ftpd_banner=Welcome to blah FTP service.  #设定Vsftpd的登陆标语。

    #deny_email_enable=YES
    # (default follows)
    #banned_email_file=/etc/vsftpd/banned_emails

    chroot_list_enable=NO #禁止用户登出自己的FTP主目录。

    # (default follows)
    #chroot_list_file=/etc/vsftpd/chroot_list

    ls_recurse_enable=NO  #禁止用户登陆FTP后使用"ls -R"的命令。该命令会对服务器性能造成巨大开销。如果该项被允许，那么挡多用户同时使用该命令时将会对该服务器造成威胁。
    listen=YES 设定该Vsftpd服务工作在StandAlone模式下
    #listen_ipv6=YES

    userlist_enable=YES  #设定userlist_file中的用户将不得使用FTP。
    #userlist_deny=NO
    tcp_wrappers=YES  #设定支持TCP Wrappers

    #下边是关于虚拟用户的重要配置
    guest_enable=YES  #设定启用虚拟用户功能。
    guest_username=virtualhost  #指定虚拟用户的宿主用户。
    virtual_use_local_privs=YES  #设定虚拟用户的权限符合他们的宿主用户。
    pam_service_name=vsftpd  #设定PAM服务下Vsftpd的验证配置文件名。因此，PAM验证将参考/etc/pam.d/下的vsftpd文件配置。
    user_config_dir=/etc/vsftpd/virtualconf  #设定虚拟用户个人Vsftp的配置文件存放路径。也就是说，这个被指定的目录里，将存放每个Vsftp虚拟用户个性的配置文件，一个需要注意的地方就是这些配置文件名必须和虚拟用户名相同。
    
    
    


