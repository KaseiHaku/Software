免费 DDNS 服务商:
    https://www.duckdns.org/                    # 可以申请 *.duckdns.org 作为后缀的子域名
    https://ydns.io/

DuckDNS 搭建:
    shell> # 进光猫 超级管理员 登陆界面，注意不是普通 user 
           # 联通光猫地址: 192.168.1.1/cu.html         密码不知道可以打维修师傅电话帮查，如果不行那只能试试 路由模式 能否 DDNS 了，IPv6
           # 登陆 超级管理员，将光猫从 路由模式 改为 桥接模式，然后使用路由器拨号上网，这样路由器才能获取到 IPv6 地址，
           # @trap 改桥接时，不要修改 VLAN 模式(不启用untag/透传trasparent/改写tag) 和 VLAN ID(填错之后无法上网)
           # @trap 改桥接之后 禁用掉 ?_TR069_R_VID_?? 协议的连接,该连接是 运营商用来控制你的光猫的
           # @tips 光猫 路由模式 也可以获取到 IPv6 地址，但是我没尝试过
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
    #     # ?domain         值可以为 xxx 或者 xxx.duckdns.org; 如果有多个，那么使用 ',' 分隔，即: xxx,yyy,zzz
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
    
    
    
