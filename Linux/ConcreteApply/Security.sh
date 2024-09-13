# 禁 ping
shell> cat <<-'EOF' | tee /etc/sysctl.d/00-security.conf
net.ipv4.icmp_echo_ignore_all = 1
net.ipv6.icmp.echo_ignore_all = 1
EOF
shell> sysctl --system
