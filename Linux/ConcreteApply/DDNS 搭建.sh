免费 DDNS 服务商:
    https://www.duckdns.org/                    # 可以申请 *.duckdns.org 作为后缀的子域名
    https://ydns.io/

光猫/路由器配置:
    光猫：
        必须将光猫从 路由模式 改成 桥接模式，才能使用主路由器拨号上网
        - 进光猫 超级管理员 登陆界面，注意不是普通 user 
          联通光猫地址: 192.168.1.1/cu.html         密码不知道可以打维修师傅电话帮查，如果不行那只能试试 路由模式 能否 DDNS 了，IPv6
        - 登陆 超级管理员，将光猫从 路由模式 改为 桥接模式，然后使用路由器拨号上网，这样路由器才能获取到 IPv6 地址，
          联通光猫配置如下:
            基本配置 > 上行线路配置 > WAN 连接
                  连接名称: 新建 WAN 连接        # 选择当前存在的，且业务类型为 INTERNET 的连接。通常连接名称类似： 2_INTERNET_B_VID_12
                  使能：[勾选]
                  封装类型: PPPoE
                  连接模式: 桥接            # 就是这里，把 “路由” 改成 “桥接”，其他配置不要动，这里写了只是方便定位当前配置的位置
                  业务类型：INTERNET
                  
            基本配置 > LAN 配置 
                DHCPv4 配置
                    IP 地址: 192.168.1.1
                    子网掩码: 255.255.255.0
                    
                    启用 DHCP 服务：[取消勾选]
                # RA(Router Advertisement/路由通告)：保持默认开启，关闭可能导致无法上网。
                # 用于路由器想本地链路通告网络配置信息，包括自动配置网络参数、提供默认网关、地址自动配置等功能
                RA 配置:
                    使能：[勾选] 
                DHCPv4 配置：
                    启用 DHCP 服务：[取消勾选]
                    
            基本配置 > WAN 配置 
                无线基本配置：
                    # 保持默认即可
                无线高级配置：
                    无线开关：[取消勾选]

            基本配置 > 远程管理
                # 保持默认即可

            高级配置
                # 保持默认即可
                    
        - 其他配置：
            关掉 1_TR069_R_VID_14 类型的连接: 
                基本配置 > 上行线路配置 > WAN 连接 
                     连接名称: 1_TR069_R_VID_14
                     使能：[取消勾选]
            关掉 光猫自带的 无线网
            
                  
        @trap 改桥接时，不要修改 VLAN 模式(不启用untag/透传trasparent/改写tag) 和 VLAN ID(填错之后无法上网)
        @trap 改桥接之后 禁用掉 ?_TR069_R_VID_?? 协议的连接,该连接是 运营商用来控制你的光猫的
        @tips 光猫 路由模式 也可以获取到 IPv6 地址，但是我没尝试过
    
    主路由器:
        上网设置:
            基本设置：
                上网方式: 宽带拨号上网
            WAN 口设置:
                固定 WAN 口
            高级设置：
                拨号模式: 自动选择拨号模式
                连接模式: 自动连接，在开机和断线后自动连接
                服务名: 保持为空，不要填写任何内容
                服务器名：保持为空，不要填写任何内容
        LAN 口设置:
            LAN 口 IP 设置: 手动
            IP 地址: 192.168.0.1
            子网掩码: 255.255.255.0
        IPv6 配置:
            基本设置：
                IPv6 功能：开启
                WAN 口连接类型: 宽带拨号上网    # [勾选]复用 IPv4 拨号链路
            高级设置:
                IPv6 地址获取协议: [勾选]自动 []DHCPv6 []SLAAC []固定 IP 
                前缀授权: 开启
                DNS 服务器： [勾选]自动获取 []手动设置
            局域网设置：
                主机配置： DHCPv6
        硬件 NAT:
            硬件 NAT: 开启
        DHCP 服务器：
            DHCP 服务器：开
            地址池开始地址：192.168.0.100
            地址池结束地址：192.168.0.199
            网关: 0.0.0.0
            首选 DNS 服务器：223.5.5.5
            备用 DNS 服务器：8.8.8.8
                
        
    副路由器:
        上网设置:
            基本设置：
                上网方式: 自动获得 IP 地址
            WAN 口设置:
                固定 WAN 口
            高级设置：
                首选 DNS 服务器：0.0.0.0
                备用 DNS 服务器：0.0.0.0
        LAN 口设置:
            LAN 口 IP 设置: 手动
            IP 地址: 192.168.0.2
            子网掩码: 255.255.255.0
        IPv6 配置:
            基本设置：
                IPv6 功能：开启
                WAN 口连接类型: 自动获取 IPv6 地址（DHCPv6/SLAAC）
            高级设置:
                IPv6 地址获取协议: [勾选]自动 []DHCPv6 []SLAAC []固定 IP 
                前缀授权: 开启
                DNS 服务器： [勾选]自动获取 []手动设置
            局域网设置：
                主机配置： DHCPv6
        硬件 NAT:
            硬件 NAT: 开启
        DHCP 服务器：
            DHCP 服务器：关
            地址池开始地址：192.168.0.10
            地址池结束地址：192.168.0.99
            网关: 192.168.0.1
            首选 DNS 服务器：192.168.0.1
            备用 DNS 服务器：223.5.5.5








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

坑:
    如果使用 CloudFlare 配置 CNAME 映射到 xxx.duckdns.org 上，切忌不能配置 Proxied, 只能是 DNS Only 模式
    如果光猫改 bridge 之后，网速变慢
        - 尝试修改路由器 MTU <= 1400
        - 尝试光猫时间戳是否正确，不正确修改 NTP 服务器
        
    
    
