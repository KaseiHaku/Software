Concept:
    存储类型：
        按存储方式分：
            块存储：iscsi, rbd
            文件存储：nfs,glusterfs,cephfs
            对象存储：ceph
                file = metadata + content
                MDS(Metadata Server, 元数据服务器): 只保存 file 的 metadata
                OSD(Object-based Storage Device): 主要负责存储对象的数据，即 content
        按存储位置分: 
            本地存储：
                DAS(Direct-attached Storage) 类：emptyDir, hostPath
            网络存储：
                集中式存储：
                    SAN(Storage Area Network) 类：iscsi, fc
                        优点: 1. 整合廉价硬盘 2. 传输速度快
                        缺点: 1. 主机间数据无法共享 2. 各个操作系统使用的文件系统不一样 3. 扩展性差，需要额外买组网设备，造价高

                    NAS(Network Attached Storage) 类：nfs
                        优点：1. 造价低 3. 方便共享
                        缺点：1. 带宽低，延时大 2. CS架构，单台 Server 抗不住大数据量

                分布式存储(云存储): 
                    SDS(Software Defined Storage): glusterfs, cephfs, rbd, cinder, aws, azureﬁle

            各个存储方式适用场景：
                SAN: 文件数量: 百万级以下；延时：十毫秒以下；数据类型: 结构化数据
                NAS: 文件数量: 亿级以下；延时: 百毫秒以下；数据类型：结构化，半结构化，非结构化数据
                SDS: 文件数量: 万亿级以下；延时：秒以下；数据类型: 半结构化，非结构化数据
                
Volumes:
    # @doc https://www.modb.pro/db/120794
    Types:
        ######## K8s 对象存储类型
        configMap: 将 ConfigMap 挂载为 volumes 给 Container 使用
        secret: 
            将 Secret 作为 volume 挂载到 Pod 中，因为是挂载为 tmpfs(临时内存文件系统)，所以在实际文件系统中是找不到的
            当 Secret 作为 subPath volume 挂载到 Container 时，Secret 不会接收任何更新
        downwardAPI: 使 Container 能获取到当前 Pod 的相关信息。
            方式一: 环境变量方式
                将 Pod 的信息使用 fieldRef 放到 Container 的环境变量中
            方式二: Volume 挂载方式
                将 Pod 的信息作为文件，挂载到 Container 中

        ######## 逻辑存储类型
        persistentVolumeClaim: 只声明需要的 volume，实际绑定延迟到 pod 运行
        projected: 将多个已经存在的 volmue 资源，投影到同一个 目录 下

        ######## Temporary 临时存储类型
        emptyDir:
            跟随 Pod 的生命周期，Pod 中所有的 Container 都可以访问

        ######## Ephemeral 短暂存储类型
        hostPath: 从 node 所在主机的 文件系统 挂载
        local: 
            只能用于 静态 PersistentVolume 的创建
            必须指定 PV 的 nodeAffinity，k8s 根据 nodeAffinity 来调度绑定到该 PV 的上的 Pod 具体到哪个 Node 上
            和 hostPath 的区别是：
                local 类型本身已经绑定了 Node，所以使用该 PV 的 Pod 会自动调度到该 Node 上，
                而使用 hostPath 类型 Volume 的 Pod 可以随便调度到任何 Node 上，这会造成数据丢失

        ######## Persistent 存储类型
        cephfs:
            RWO: ✓, ROX: ✓, RWX: ✓      
            RWO = ReadWriteOnce = volume 可以被单节点以 read-write 模式挂载
            ROX = ReadOnlyMany = volume 可以被多节点以 read-only 模式挂载
            RWX = ReadWriteMany = volume 可以被多个节点以 read-write 模式挂载

            适用于 访问简单 要求快速 扩容 和 缩容 的场景
        fc(fibre channel):
            RWO: ✓, ROX: ✓, RWX: -
        glusterfs: 开源网络文件系统
            RWO: ✓, ROX: ✓, RWX: ✓
            适用于 大量的文件，且移动不频繁，即: 归档
        iscsi: 多读，单读写
            RWO: ✓, ROX: ✓, RWX: -
        nfs: 额外一个主机当作 NFS 服务器，k8s 所有 node 作为 NFS 的 client 来将文件存储到 NFS 服务器中
            RWO: ✓, ROX: ✓, RWX: ✓
        portworxVolume: 非开源产品，小规模集群适用
            RWO: ✓, ROX: -, RWX: ✓
        rbd: CSI(Container Storage Inteface) 迁移中
            RWO: ✓, ROX: ✓, RWX: -
        IOMesh:

        ######## 三方扩展 存储类型
        csi(ContainerStorageInterface):
            
            subPath: 
                一个 Pod 中的多个 Container 的 volumeMounts 挂载 Pod 中配置的 volume 的 子路径，而不是 root，
                这样一个 Pod 中的 volume 可以将各个子目录分别挂载到 Pod 中不同的 Container 中
                
            Mount propagation: 同一个 node 中跨 Pod 和 Container 共享 volmue
                
Persistent Volumes: 持久卷，K8s 对存储类型的抽象
    # @doc https://kubernetes.io/docs/concepts/storage/persistent-volumes/#types-of-persistent-volumes
    K8s 中有两种方式可以 provision PV:
        静态 PV：由集群管理员手工创建 PV
        动态 PV：
            当 PVC 没有匹配到符合条件的 静态 PV 时，集群会根据 StorageClass 尝试动态创建 PV 给 PVC 使用，
            如果 PVC 的 spec.storageClassName = "", 那么说明该 PVC 禁止使用 动态 PV 
            开启 动态 PV 需要开启 api-server 的 DefaultStorageClass admission controller
 
            
Projected Volumes:
Ephemeral Volumes: 
    临时卷：生命周期 = Pod

Storage Classes: 由管理员创建，可以用来动态的创建存储卷和 PV
Dynamic Volume Provisioning:
Volume Snapshots:
Volume Snapshot Classes:
CSI Volume Cloning:
Storage Capacity:
Node-specific Volume Limits:
Volume Health Monitoring:
