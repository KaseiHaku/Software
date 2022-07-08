Ceph Storage Cluster 基础组件：
    Ceph Monitor                        ceph-mon
    Ceph Manager                        ceph-mgr
    Ceph OSD(Object Storage Daemon)     ceph-osd
    Ceph Metadata Server                ceph-mds
    
推荐硬件配置：
    https://docs.ceph.com/en/quincy/start/hardware-recommendations/  最后
 
 
安装：
    Cephadm: 
    Rook: 如果 ceph 部署在 k8s 中，或者需要连接到 k8s，那么推荐使用这个工具部署
        https://rook.io/
        
        
################################################### Rook ####################################        
# Ceph 先决条件，以下最少满足一项
#   1. 原始设备(没分区 或 没有格式化为指定文件系统)
#   2. 原始分区(没有格式化为指定文件系统)
#   3. k8s storage class 中可用的 block 模式的 PV 

# 虚拟机新建一个新的 硬盘

# K8s 中部署 Admission Controller，主要用于提供额外的 Rook 配置的校验
# @trap 部署 Admission Controller 必须先安装 cert manager
shell> kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.7.1/cert-manager.yaml

# 安装 LVM 包
shell> helm repo add rook-release https://charts.rook.io/release
shell> helm install --create-namespace --namespace rook-ceph rook-ceph rook-release/rook-ceph
shell> helm install --create-namespace --namespace rook-ceph rook-ceph rook-release/rook-ceph -f values.yaml    # -f 指定配置文件

# 检查内核是否包含编译了 RBD Module
shell> modprobe rbd

# 如果需要创建 CephFS，那么需要检查内核版本 > 4.17
shell> uname -a


 
