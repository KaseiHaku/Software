# wiki: https://wiki.nftables.org/wiki-nftables/index.php/Quick_reference-nftables_in_10_minutes
# nftables 是什么？
# 一套新的 linux 包过滤管理工具，用于替代 iptables

# Ruleset   1:n     Table
# Table     1:n     Chain, Set, Map, Flowtable, StatefuleObject
# Set       1:n     Element


# Ruleset
    shell> nft {list | flush} ruleset [family]      # 格式
    shell> nft list ruleset inet                # 这里的 最后一个单词，就是 地址家族
    shell> nft flush ruleset netdev
 
# Tables
# Table 包含 Cahin，Set，Map,  状态对象
    
    # 查
    shell> nft list tables [family]             # 列出所有 table
    
    # 增
    shell> nft create table [family] mytable {flags dormant;}   # 创见一个 table
    
    # 删
    shell> nft delete table [family] mytable handle handleId          # 删除指定的 table
    
    # 改
    shell> nft add table inet mytable { flags dormant; }        # 临时 禁用一个 table
    shell> nft add table inet mytable                           # 重新 启用一个 table
    
    # Miscellaneous
    shell> nft list table [family] tableName            # 列出指定 table 中的所有 chain 和 rule
    shell> nft flush table [family] tableName           # 清空指定 table 中的所有 chain 和 rule
    shell> nft delete table [family] tableName


# Chain: BaseChain RegularChain
# chain 是 rule 的容器
    shell> nft add chain inet myTable myChain { type filter hook input priority filter; }       # 指定 table 添加 chain
    
    # 增
    # 支持的 chain type
    #   Type            Families        Hooks                                           Description
    #   filter          all             all 
    #   nat             ip,ip6,inet     prerouting, input,output, postrouting           
    #   route           ip,ip6          output
    
    shell> nft {add | create} chain [family] table chain [{ type type hook hook [device device] priority priority; [policy policy ;] [comment comment ;] }]
    shell> nft {delete | list | flush} chain ['family] table chain
    shell> nft list chains [family]
    shell> nft delete chain [family] table handle handle
    shell> nft rename chain [family] table chain newname
    

# Rule
    {add | insert} rule [family] table chain [handle handle | index index] statement ... [comment comment]
    replace rule [family] table chain handle handle statement ... [comment comment]
    delete rule [family] table chain handle handle


    shell> nft add rule inet myTable counter                # 指定 table 添加 rule

# Set
# 匿名 set 

# Map

# Element

# Flowtable

# Stateful Objects

# Expression
    shell> nft describe expression      # 解释表达式
    shell> nft describe dataType        # 解释数据类型
    
    # data type
    # Primary Expression
        # Meta Expression
        # Socket Expression
        # OSF Expression
        # FIB Expression
        # Routing Expression
        # IPSEC Expression
        # NUMGEN Expression
        # Hash Expression
    # Payload Expression
        # ether
        # vlan
        # arp
        # ip
        # icmp
        # igmp
        # ip6
        # icmpv6
        # tcp
        # udp
        # udplite
        # sctp
        # dccp
        # ah
        # esp
        # comp
        # RAW PAYLOAD EXPRESSION
        # EXTENSION HEADER EXPRESSIONS
        # CONNTRACK EXPRESSIONS
    # STATEMENTS
        VERDICT STATEMENT
        PAYLOAD STATEMENT
        EXTENSION HEADER STATEMENT
        LOG STATEMENT
        REJECT STATEMENT
        COUNTER STATEMENT
        CONNTRACK STATEMENT
        META STATEMENT
        LIMIT STATEMENT
        NAT STATEMENTS
        TPROXY STATEMENT
        SYNPROXY STATEMENT
        FLOW STATEMENT
        QUEUE STATEMENT
        DUP STATEMENT
        FWD STATEMENT
        SET STATEMENT
        MAP STATEMENT
        VMAP STATEMENT

# MONITOR

# 帮助
shell> nft -h       # 查看帮助

# table: chain 的容器
# family: 表示一个 table 的类型：有以下几种类型：  ip, arp, ip6, bridge, inet, netdev
shell> nft list tables inet
shell> nft list tables inet tableName -n -a
shell> nft add table inet tableName
shell> nft delete table inet tableName
shell> nft flush table inet tableName

# chain: rule 的容器
# type: refer to the kind of chain: 有以下几种类型：filter, route, nat
# hook: 表示 packet 在内核处理过程中的具体的阶段
#       ip, ipv6, inet: prerouting, input, forward, output, postrouting
#       arp: input, output
#       bridge: 同 ip, ipv6, inet
#       netde: ingress
# priority: 用于配置 chain 的顺序，或者 netfilter 操作，可以使用的值
#       NF_IP_PRI_CONNTRACK_DEFRAG (-400), 
#       NF_IP_PRI_RAW (-300), 
#       NF_IP_PRI_SELINUX_FIRST (-225), 
#       NF_IP_PRI_CONNTRACK (-200), 
#       NF_IP_PRI_MANGLE (-150), 
#       NF_IP_PRI_NAT_DST (-100), 
#       NF_IP_PRI_FILTER (0), 
#       NF_IP_PRI_SECURITY (50), 
#       NF_IP_PRI_NAT_SRC (100), 
#       NF_IP_PRI_SELINUX_LAST (225), 
#       NF_IP_PRI_CONNTRACK_HELPER (300)
# policy: 表示一个 chain 的最终裁决（verdict） 声明，有以下几种类型：accept, drop, queue, continue, return.
shell> nft list chain familyName tableName chainName
shell> nft add chain familyName tableName chainName {type typeName hook hookName device deviceName priority priorityName\; policy policyName\;}
shell> nft rename chain familyName tableName chainName newChainName
shell> nft delete chain familyName tableName chainName
shell> nft flush chain familyName tableName chainName

# rule: 指向（refer to）一个 action
# handle: 是一个 rule 的标识符，是个数字
# position: 是一个 rule 的定位，用于指定插入位置
# matches: 是一个 packet 的线索，用于访问特定的 packet 和 为特定的 packet 创建 filter：
#       常见的有以下几种：ip, ipv6, tcp, udp, icmp, icmpv6, ether(mac), arp, meta 等
# statements: 表示一个对 匹配的 packet 的 action，分为 terminal 和 non-terminal 动作，相当于 java 的 stream ，只能有一个 terminal action
#           verdict statement: 用于改变流程走向，和 发布一个 policy 决定：有以下几种：
#               accpt: 接受数据包并停止剩余规则评估
#               drop: 丢弃数据包并停止剩余规则评估
#               queue: 将数据包排队到用户空间并停止剩余规则评估
#               continue: 使用下一条规则继续进行规则评估
#               return: 从当前链返回并继续执行最后一条链的下一条规则
#               jump chainName: 跳转到指定的规则链，当执行完成或者返回时，返回到调用的规则链
#               goto chainName: 类似于跳转，发送到指定规则链但不返回
#           log statement: log level debug 
#           reject statement: reject with icmpx type port-unreachable    # 只适用于 icmp
#           counter statement: counter packets 0 bytes 0
#           limit statement: limit rate 1025 mbytes/second burst 1025 kbytes
#           nat statement: 
#               dnat ct mark map { 0x00000014 : 1.2.3.4}
#               snat 2001:838:35f:1::-2001:838:35f:2:::100
#               masquerade to :1024-2048
#           queue statement: queue num 4-5 fanout bypass
shell> nft add rule [<family>] <table> <chain> <matches> <statements>
shell> nft insert rule [<family>] <table> <chain> [position <position>] <matches> <statements>
shell> nft replace rule [<family>] <table> <chain> [handle <handle>] <matches> <statements>
shell> nft delete rule [<family>] <table> <chain> [handle <handle>]

# Miscellaneous

shell> nft -n       # 数字方式显示
shell> nft -NSuyjT 


shell> nft list ruleset     # 显示当前所有规则集
shell> nft flush ruleset    # 清空规则




################################ Debug ################################
# 需要先使用 meta nftrace set 1 打标记 才能跟踪
# 
shell> nft add rule filter input ip saddr 10.0.0.1 meta nftrace set 1            # 打标记
shell> nft monitor trace            # 监控

