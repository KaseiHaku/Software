网络配置方法 {
    直接修改配置文件 {
        /etc/sysconfig/network-scripts/ifcfg-ethX
        /etc/sysconfig/network-scripts/route-ethX
    }
    
    # CentOS 8 以后版本只支持这种方式
    NetworkManager {
        shell> nmcli            # 管理网络
    }
}

    
   
网卡/协议栈 架构 {
    协议栈：netfilter 运行在 协议栈 中
        │
        ├─ 网卡 1
        ├─ 网卡 2
        └─ Bridge 1
    

}
