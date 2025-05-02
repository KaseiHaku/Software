CA 证书配置：
    Debian:
        shell> cp xxx.crt /usr/share/ca-certificates/                # debian 系必须是 .crt 结尾的文件名
        shell> cp xxx.crt /usr/local/share/ca-certificates/
        shell> chmod 644 xxx.crt
        # 该命令会将以上两个目录中的文件添加到 /etc/ssl/certs/ca-certificates.crt 文件和 /etc/ssl/certs 目录下的哈希链接中。
        shell> update-ca-certificates
        
    RedHat:
        shell> cp xxx.crt /etc/pki/ca-trust/source/anchors/            # redhat 系可以是 .crt 或 .pem 结尾的文件名
        shell> chmod 644 xxx.crt
        # 该命令会u更新 /etc/pki/ca-trust/extracted/ 目录下的不同格式的信任库（如 PEM bundle, OpenSSL 目录, Java KeyStore）。
        shell> update-ca-trust extract

    Arch:
        shell> cp xxx.crt /etc/ca-certificates/trust-source/anchors/ 
        shell> chmod 644 xxx.crt
        # 这会更新系统的信任锚点，并兼容旧的 /etc/ssl/certs 结构。
        shell> trust extract-compat
        shell> trust list        # 查看所有 CA 证书
        
