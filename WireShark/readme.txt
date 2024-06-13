# https://www.wireshark.org/docs//wsug_html_chunked/ChCapCaptureFilterSection.html
Wiresharke filter 分为两种:
    capture filter: 用于捕获 packet
        [src|dst] host <host>
        ether [src|dst] host <ehost>
        gateway host <host>
        [src|dst] net <net> [{mask <mask>}|{len <len>}]
        [tcp|udp] [src|dst] port <port>
        less|greater <length>
        ip|ether proto <protocol>
        ether|ip broadcast|multicast
        <expr> relop <expr>
    dispaly filter: 用于显示过滤，防止抓到太多包
        




# 过滤器表达式
# https://www.tcpdump.org/manpages/pcap-filter.7.html
filter expression = primitive && primitive || !primitive
pirmitive = [type] [dir] [proto] identifier
    proto(protocol):    ether, fddi, tr, wlan, ip, ip6, arp, rarp, decnet, tcp and udp
    dir(direction):     src, dst, src or dst, src and dst, ra, ta, addr1, addr2, addr3, and addr4
    type:               host, net, port and portrange.
            
# Logical Operation
    and         &&
    or          ||
    not         !

# Compare Operator
    any_eq              ==
    all_ne              !=
    all_eq              ===
    any_ne              !==
    gt                  >
    ge                  >=
    lt                  <
    le                  <=
    contains                            Protocol, field or slice contains a value
    matches             ~               Protocol or text field matches a Perl-compatible regular expression
    bitwise_and         &               Bitwise AND is non-zero
    
