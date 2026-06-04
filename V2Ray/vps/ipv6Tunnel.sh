################################ CentOS ################################
modprobe ipv6
ip tunnel add he-ipv6 mode sit remote 66.XXX.XXX.XX local 114.XXX.XXX.119 ttl 255
ip link set he-ipv6 up
ip addr add 2001::2/64 dev he-ipv6
ip route add ::/0 dev he-ipv6
ip -f inet6 addr



################################ Debian ################################
# 添加以下内容到 /etc/network/interfaces:
auto he-ipv6
iface he-ipv6 inet6 v4tunnel
        address 2001::2/64
        netmask 64
        endpoint 66.XXX.XXX.XX
        local 114.XXX.XXX.119
        ttl 255
        gateway 2001::1
