免费 DDNS 服务商:
    https://www.duckdns.org/                    # 可以申请 *.duckdns.org 作为后缀的子域名
    https://ydns.io/

DuckDNS 搭建:
    shell> # 登陆 https://www.duckdns.org/   这里是三方登陆，选自己喜欢的就行，这里是 github
    shell> # 复制 token 保存
    shell> # 新建一个子域名，例如: xxx.duckdns.org
    shell> mkdir -p ~/Script/duckdns 
    shell> cd ~/Script/duckdns
    shell> cat <<-'EOF' | tee ./duck.sh
    curIpv6=`ip -br -family inet6 addr show dev wlp3s0 scope global -deprecated mngtmpaddr | head -n 1 | tr -s [:blank:] | cut -d ' ' -s -f 3- | cut -d / -f 1`
    # 清除 DNS Record: 
    #     echo url="https://www.duckdns.org/update?domains=xxx.duckdns.org&token=a7c4d0ad-114e-40ef-ba1d-d217904a50f2&clear=true" | curl -k -K -
    # 更新 DNS Record: 
    #     # @doc https://www.duckdns.org/spec.jsp
    #     # &ip             值可以为 ipv4 或者 ipv6 或者为空，为空表示自动检测当前 ipv4 和 ipv6 地址
    #     # &ipv6           值可以为 ipv6，如果该参数存在，则自动检测失效
    #     echo url="https://www.duckdns.org/update?domains=xxx.duckdns.org&token=a7c4d0ad-114e-40ef-ba1d-d217904a50f2&verbose=true&ip=" | curl -k -o ~/Script/duckdns/duck.log -K -
    #     echo url="https://www.duckdns.org/update?domains=xxx.duckdns.org&token=a7c4d0ad-114e-40ef-ba1d-d217904a50f2&verbose=true&ipv6=2002::1001" | curl -k -o ~/Script/duckdns/duck.log -K -
    echo url="https://www.duckdns.org/update?domains=xxx.duckdns.org&token=a7c4d0ad-114e-40ef-ba1d-d217904a50f2&verbose=true&ipv6=${curIpv6}" | curl -k -o ~/Script/duckdns/duck.log -K -
    EOF
    shell> chmod 700 duck.sh              # 修改文件权限
    shell> . ./duck.sh                    # 手动触发
    shell> tail -fn 500 ./duck.log        # 查看日志
    


    
    # 配置定时任务自动触发
    # @tips 使用 shell> crontab -e 编辑定时任务，保存时可以校验 cron 表达式是否正确
    #       格式如下: 
    #           # 不需要像 /etc/crontab 中一样配置 username，因为 shell> crontab -e 命令默认使用当前用户
    #           */5 * * * *     ~/duckdns/duck.sh >/dev/null 2>&1
    # 
    shell> cat <<-"EOF" >> /etc/crontab
    # Duck DDNS 定时更新，每隔 15 分钟更新一次
    0-50/15 * * * * kasei . /home/kasei/Script/duckdns/duck.sh >/dev/null 2>&1
    EOF
    
    
    
