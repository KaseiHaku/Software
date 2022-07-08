# 网桥管理
    shell> ip addr show type bridge				# 显示所有网桥信息
    shell> ip addr show type bridge br2 	    # 显示网桥 br2 的信息
    shell> ip link add br2 type bridge 			# 创建一个名为 br2 的网桥
    shell> ip link set dev enp4s0 master br2    # 将物理接口 enp4s0 添加到 br2 网桥下
    shell> ip link del br2 type bridge 			# 删除 br2 网桥
    shell> ip link set dev enp4s0 nomaster	    # 删除物理接口 enp4s0 的网桥配置
    
