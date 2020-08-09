# nftables 是什么？
# 一套新的 linux 包过滤管理工具，用于替代 iptables

shell> nft -h       # 查看帮助
shell> nft -n       # 数字方式显示

shell> nft -NSuyjT 


shell> nft list ruleset     # 显示当前所有规则集
shell> nft list tablse      # 显示当前所有的表，chain 的容器
shell> nft list chains      # 显示所有的链，rule 的容器，分为 base chain 和 regular chain，base chain 是 package 的入口，regular chain 用于跳转


