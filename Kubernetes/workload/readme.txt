Pods:  
    k8s 的最小调度单位，一个 pod 中可以有多个 container
    
Workload Resources:
    ReplicaSet: 指定一个 Pod 模板需要存在多少个实例


    Deployment: 使用 ReplicaSet，并额外支持滚动更新
        用于部署 无状态的 Pod
        部署出来的 Pod 的 名称 和 IP 都是随机的
    
    StatefulSet: 
        用于管理 有状态的 Pod
        特性：
            1. 部署出来的 Pod 的 名称 是有顺序的，比如 StatefulSet 名字为 redis，那么 pod 名就是 redis-0, redis-1, ...
            2. StatefulSet 中 ReplicaSet 的启停顺序是严格受控的，操作第 N 个 pod 一定要等前 N-1 个执行完才可以
            3. StatefulSet 中的 Pod 采用稳定的持久化储存，并且对应的 PV 不会随着 Pod 的删除而被销毁
            4. StatefulSet 必须要配合 Headless Service 使用，它会在 Headless Service 提供的 DNS 映射上再加一层，最终形成精确到每个 pod 的域名映射，
               格式如下：$(podname).$(headless service name)
               有了这个映射，就可以在配置集群时使用域名替代 IP，实现有状态应用集群的管理
    
    
    DaemonSet
    Jobs
    Automatic Clean-up for Finished Jobs
    CronJob
    ReplicationController
