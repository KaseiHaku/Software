免费 DDNS 服务商:
    https://www.duckdns.org/                    # 可以申请 *.duckdns.org 作为后缀的子域名
    https://desec.io/                        # 已经无法申请子域名了
    https://ydns.io/

DuckDNS 搭建:
    shell> # 登陆 https://www.duckdns.org/   这里是三方登陆，选自己喜欢的就行，这里是 github
    shell> # 复制 token 保存
    shell> # 新建一个子域名，例如: xxx.duckdns.org
    shell> mkdir duckdns
    shell> cd duckdns
    shell> cat <<-'EOF' | tee ./duck.sh
    echo url="https://www.duckdns.org/update?domains=exampledomain&token=a7c4d0ad-114e-40ef-ba1d-d217904a50f2&ip=&ipv6=" | curl -k -o ~/duckdns/duck.log -K -
    EOF
    shell> chmod 700 duck.sh
    shell> crontab -e        # 新增一行: */5 * * * * ~/duckdns/duck.sh >/dev/null 2>&1
    shell> ./duck.sh        # 手动触发
    
    
