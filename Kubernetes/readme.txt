Concept:
    Cluster Architecture:
        Nodes: 
            就是 k8s 集群中工作的机器，不管是 物理机 还是 虚拟机，机器中会安装一系列组件，使该 机器 能够被 k8s 管理，而成为一个 node
            相关组件：
                @trap 以下组件在 k8s 所有 node 中存在，包括 control-plane node
                kubelet: 
                    服务运行方式: systemctl
                    node 上的监控程序，确保 pod 中的 container 正常运行
                    
                kube-proxy: 
                    服务运行方式: docker
                    网络代理，用于实现 k8s 中 Service 的概念，
                    监听 API server 中 service 和 endpoint 的变化情况，并通过 iptables 等来为服务配置负载均衡（仅支持 TCP 和 UDP）
                    
                Container runtime: 
                    服务运行方式: systemctl
                    所有 Kubernetes CRI 实现，例如: containerd, CRI-O,
                    
        Control Plane:
            控制面板：包含一系列 k8s 控制组件
            相关组件:
                kube-apiserver: k8s API 的后端服务，k8s control plane 的前端
                    服务运行方式: docker
                    K8s API:
                        用于操作 k8s 集群的接口，是基于 http 协议的，提供该接口后端服务 kube-apiserver。
                        http body 的内容是 json，
                        其中 kubectl 和 kubeadm 都是通过将 .yml 文件转成 json, 然后使用 http 协议发送给 kube-apiserver 来完成集群操作的
                    
                etcd: 负责保存 Kubernetes Cluste r的配置信息和各种资源的状态信息
                    服务运行方式: docker
                    
                kube-scheduler: 负责决定将 Pod 放在哪个 Node 上运行
                    服务运行方式: docker
                
                kube-controller-manager: k8s 控制器(controller) 的 管理器，其中 controller 用于保证资源处于预期的状态
                    服务运行方式: docker
                    Node controller: 当 node 宕机时，负责通知 和 响应
                    Job controller: 监视一次性的任务，然后创建 pod 运行这写 task
                    Endpoints controller: 端点(接口)
                    Service Account & Token controllers: 为新的 namespace 创建 默认账号 和 api 访问 token
                
                cloud-controller-manager: 云控制器的管理器
                    服务运行方式: docker
                    用于将自己的集群 连接到 云服务商的 API 上，如果 k8s 运行在自己的机房 或者 PC 上，那么该组建是没有的
                    Node controller:
                    Route controller:
                    Service controller:
                
        Controllers: 
            跟踪至少一个 k8s resource，这些 resource obj 都有一个 spec 字段表明想要的达到的状态，
            controller 的作用的就是 当 resource obj 偏离 spec 指定的状态时，使之回到该状态
            
            K8sResourceObjects:
                k8s 通过 .yml 描述一个 对象 在 k8s 集群中的状态，类似与 SQL，都是基于 intent(目标，意图) 设计的
                每个 obj 都有 spec 和 status 两个内嵌 obj 来 govern 该 obj 的配置:
                    spec: 用于描述 想要该 obj 是什么样的状态
                    status: 用于描述 该 obj 当前是什么状态(不存在与 yml 文件中)
                    
        Cloud Controller Manager:
            主要作用是 连接 k8s cluster 和 云服务商提供的 API
            
        Container Runtime Interface(CRI): 
            主要作用是 使 k8s 能够控制 node 中的 container 的生命周期
            
        Garbage Collection:
            主要负责，pod 启动失败 或者 其他情况下，不再使用的资源的回收
            
        Addons: 插件，使用 k8s 的资源，拓展集群功能，插件属于 kube-system namespace
            Cluster DNS: 所有 k8s 集群都应该有一个 集群 DNS 服务器，通过 k8s 启动的 container 都自动包含该 DNS 服务器
            Web UI(Dashboard):
            Container Resource Monitoring:
            Cluster-level Logging: 集中管理 container 的 log
    
    Containers:
        Images: 就是 docker 的 image
        Container Environment: 就是 container 中的环境变量，挂载的 volume 等
        Runtime Class: 
        Container Lifecycle Hooks: 用于触发基于 hook 的代码

        
    Configuration:
        ConfigMaps:
        Secrets:
    
    Security:
        Overview of Cloud Native Security:
            云原生安全层级：Cloud, Clusters, Containers, Code;  由外到里，外层不安全，就无法保证构建在其之上的内层是安全的
            
            Clusters:
                RBAC Authorization (Access to the Kubernetes API):
                     Role: 表示一组权限的集合，全是添加权限，没有禁用规则。必须指定 namespace
                     ClusterRole: 同上，但是不指定 namespace
                        Scenario: 
                            定义 命名空间范围资源 的权限，并在每个命名空间单独授予权限
                            定义 命名空间范围资源 的权限，并授予所有命名空间权限
                            定义 集群范围资源 的权限
                     RoleBinding: 授予权限给 user 或 一组 user。必须指定 namespace
                     ClusterRoleBinding: 同上，但是不指定 namespace
    
        User: k8s 中有两类 User=[K8S 管理的 ServiceAccount, 普通用户]
        
        K8S API 访问控制： Authentication(身份认证) -> Authorization(授权) -> AdmissionControl(准入控制，鉴权)
            Authentication:
                X509 Client Certs：
                    Preset:     
                        API Server 启动时，添加 --client-ca-file=ca.cert.pem 来配置一个 CA 证书，并开启 使用 客户端证书 进行 身份认证 的功能
                        当用户持有 集群 CA 证书 签发的 客户端证书时，
                        K8S 提取 subject 中 Common Name 字段的值当作用户名，
                        提取 Organization 字段的值 作为 该用户所在的 用户组 信息 
                    Usage: 在 ~/.kube/config 中配置证书
                    
                Static Token File: 
                    Preset:         API Server 启动时，使用 --token-auth-file=token.csv 标志，指定静态令牌文件        
                    .csv Format:    token,user,uid,"group1,group2,group3"
                    Usage:          Authorization: Bearer 31ada4fd-adec-460c-809a-9e56ceb75269
          
                Bootstrap Tokens:
                    Preset: 
                        1. API Server 启动时，使用 --enable-bootstrap-token-auth 标志 来启动当前认证方式
                        2. 在 Controller Manager 上使用 --controllers=*,tokencleaner 开启 TokenCleaner controller
                    Token Format:     TokenID.TokenSecret = [a-z0-9]{6}.[a-z0-9]{16}
                    Usage: 
                        1. shell> kubectl -n kube-system get secrets | grep bootstrap-token     # 找到 保存 token 的 Secret
                        2. Http Header 中添加 Authorization: Bearer 781292.db7bc3a58fc5f07e        
                    
                Service Account Tokens:
                    Preset:
                        API Server 启动时，
                        --service-account-key-file=*.key.pem    # 为持有者 token 签名的密钥。若未指定，则使用 API 服务器的 TLS 私钥
                        --service-account-lookup                # 如果启用，则从 API 删除的令牌会被回收。
                    Usage:
                        1. shell> kubectl get serviceaccounts sa1 -o yaml   # 查看 sa1 关联的 Secret, path: {.secrets*.name}
                        2. shell> kubectl get secret aa -o yaml     # {.data."ca.crt"} = Base64 编码的 API Server 的 CA 证书
                                                                    # {.data.token} = Base64 编码的 当前 服务账号 持有者的 JWT，即: 当前账号对应 User 的系统访问 Token
                        3. Http Header 中添加 Authorization: Bearer JWT
                        该方式认证后，
                            username = system:serviceaccount:<名字空间>:<服务账号>
                            usergroup = system:serviceaccounts 和 system:serviceaccounts:<名字空间>
                            
                        
                OpenID Connect Tokens:
                Webhook Token Authentication:
                Authenticating Proxy:
                
        Anonymous requests:
        User impersonation: 用户冒充
        client-go credential plugins:

    Policies:
        指资源分配策略
    
    Scheduling, Preemption and Eviction：
        Taints and Tolerations: 
            shell> kubectl taint --help
    Cluster Administration:
    Extending Kubernetes:
        
    
    
K8S 个组件通信示意图：
    kube-scheduler          <─────────────────────┐
    etcd            <─────────────────────────────┼───> kube-apiserver <───┬───────> kubelet
    kube-controller-manager   <───────────────────┤                        └──────────>  kube-proxy
    cloud  <─────> cloud-controller-manager <─────┘             
    
    各个组件之间通信，采用 双向 TLS 认证; 在双向认证过程中，需要用到以下证书相关的文件:
        服务器端证书：服务器用于证明自身身份的数字证书，里面主要包含了服务器端的公钥以及服务器的身份信息。
        服务器端私钥: 服务器端证书中包含的公钥所对应的私钥。公钥和私钥是成对使用的，在进行 TLS 验证时，服务器使用该私钥来向客户端证明自己是服务器端证书的拥有者。
        客户端证书: 客户端用于证明自身身份的数字证书，里面主要包含了客户端的公钥以及客户端的身份信息。
        客户端私钥：客户端证书中包含的公钥所对应的私钥，同理，客户端使用该私钥来向服务器端证明自己是客户端证书的拥有者。
        服务器端 CA 根证书: 签发服务器端证书的 CA 根证书，客户端使用该 CA 根证书来验证服务器端证书的合法性。
        客户端 CA 根证书: 签发客户端证书的 CA 根证书，服务器端使用该 CA 根证书来验证客户端证书的合法性。
    
    
    

Resources: k8s 可以管理的资源
    Workload:
        Pod: k8s 最小的调度单位，代表集群中的一组容器。这组容器只能同时运行在一个 node 中
        PodTemplate:
        ReplicationController: @deprecated 使用 RelicaSet 替代
        ReplicaSet:
        Deployment: 底层使用 ReplicaSet，但是提供额外的功能
        StatefulSet:
        ControllerRevision:
        DaemonSet:
        Job:
        CronJob:
        HorizontalPodAutoscaler:
        v2beta2:
        PriorityClass:
    Service:
        Service:
        Endpoints:
            Service 通过 selector 和 pod 建立关联，
            endpoint controller 会根据 service 关联到 pod 的 podIP 信息，创建一个与 Service 同名的 endpoint 对象，
            所以 Service 和 Endpoints 是通过 名称绑定的
            若 Service 定义中没有 selector 字段，service 被创建时，endpoint controller 不会自动创建 endpoint
        EndpointSlice:
            代表一个 Service Endpoint 的子集，一个 Service 可以存在多个 EndpointSlice 对象，
        Ingress:
        IngressClass:
    Config and Storage:
        ConfigMap: 
        Secret: 用于配置密码，密钥等
        Volume: k8s 对存储的抽象，使存储可以跨主机提供服务
        PersistentVolumeClaim:
        PersistentVolume:
        StorageClass:
        VolumeAttachment:
        CSIDriver:
        CSINode:
        CSIStorageCapacity v1beta1:
    Authentication:
        ServiceAccount:
        TokenRequest:
        TokenReview:
        CertificateSigningRequest:
        
    Authorization:
        LocalSubjectAccessReview
        SelfSubjectAccessReview
        SelfSubjectRulesReview
        SubjectAccessReview
        ClusterRole
        ClusterRoleBinding
        Role
        RoleBinding
    Policy:
        LimitRange
        ResourceQuota
        NetworkPolicy
        PodDisruptionBudget
        PodSecurityPolicy v1beta1
    Extend:
        CustomResourceDefinition
        MutatingWebhookConfiguration
        ValidatingWebhookConfiguration
    Cluster:
        Node:
        Namespace:
        Event:
        APIService:
        Lease:
        RuntimeClass:
        FlowSchema v1beta2:
        PriorityLevelConfiguration v1beta2:
        Binding:
        ComponentStatus:
    Common Definitions:
        DeleteOptions
        LabelSelector
        ListMeta
        LocalObjectReference
        NodeSelectorRequirement
        ObjectFieldSelector
        ObjectMeta
        ObjectReference
        Patch
        Quantity
        ResourceFieldSelector
        Status
        TypedLocalObjectReference
    Common Parameters:
        allowWatchBookmarks:
        continue
        dryRun
        fieldManager
        fieldSelector
        fieldValidation
        force
        gracePeriodSeconds
        labelSelector
        limit
        namespace
        pretty
        propagationPolicy
        resourceVersion
        resourceVersionMatch
        timeoutSeconds
        watch
    

Glossary:
    Affinity(姻亲): 一系列规则，用于给 scheduler 提供关于 pod 放在哪里的提示信息
    Annotation(注解): 键值对，用于给 object 提供非 识别性 的元数据 
    API Group: Kubernetes API 中一组相关的路径
    API server(): Kubernetes API 的后端 和 Kubernetes control plane 的前端，例如：kube-apiserver
    Applications(应用): 各种容器化应用程序运行的 层级
    cgroup (control group): Linux 中一组可以进行 资源隔离，核算和限制 的 进程
    Cluster(集群): 工作机器的集合，一个集群至少有一个 工作节点
    Container(容器): 包含 软件及其所有依赖的 轻量可执行镜像 
    Container Environment Variables(): Pod 中容器的环境变量
    Container Runtime(容器运行时): 一个软件，负责运行容器，例如: dockerd
    Container runtime interface (CRI): 容器运行时提供出来的 API 接口，用于和 node 上的 kubelet 进行整合
    Control Plane(控制平面): 容器编排层，提供 API 接口用于 container 的 定义，部署 和 生命周期的管理
    Controller(控制器): 监控 cluster 的状态，确保状态是想要的状态
    CustomResourceDefinition(自定义资源定义): 定义添加 resource 到 API server，而不是构建一个完整的 server
    DaemonSet(): 确保一个 Pod 的副本在 集群 中的 一组 node 中运行
    Data Plane(数据平面): 给容器分配 CPU，Memory，Network，Storage 等资源的平面
    Deployment(部署): 一个 API Object，用于管理可重复的应用，一般用来运行 不需要 保存本地数据的 Pod
    Device Plugin(设备插件): 工作在 node 上，并为 pod 提供资源访问
    Disruption(中断): 是导致一个或多个 Pod 停止服务的事件
    Docker(): 提供操作系统级虚拟化的软件技术
    Ephemeral Container(临时容器): 一种容器类型，可以临时在一个 pod 里运行
    Event(事件): 集群中某个事件的报告，通常代表这集群状态的改变
    Extensions(扩展): 一个 软件组件，使 k8s 能够支持新的硬件类型
    Finalizer(终结者，终止器): 可命名空间化的 key, 告诉 k8s 在 删除具有删除标记的资源时，等待具体的条件完成。同时提醒 controller 清理资源和删除 object
    Garbage Collection(垃圾收集器): k8s 中清理 集群资源 的所有机制的 统称
    Image(镜像): 容器的存储实例
    Init Container(初始化容器): 必须在 应用容器 运行之前完成的一个或多个初始化容器， 
    Job(工作): 一个有限的任务
    kube-controller-manager(): Control Plane 组建，用于运行 Controller 进程
    kube-proxy(): 
    Kubectl(): 
    Kubelet(): 
    Kubernetes API(): 
    Label(): 
    LimitRange(): 
    Logging(): 
    Manifest(): JSON 或 YAML 格式的 Kubernetes API 对象的规范
    Mirror Pod(): kubelet 中用于代表 static pod  的 object
    Name(): 
    Namespace(): 
    Node(): 
    Object(): 
    Pod(): 
    Pod Lifecycle(): 
    Pod Security Policy(): 
    QoS Class(服务质量等级): 
    RBAC (Role-Based Access Control)
    ReplicaSet(副本集): 
    Resource Quotas(资源配额): 
    Selector(): 用于根据 label 过滤资源
    Service(): 将运行在不同 pod 中的 app 在网络层 抽象为一个 服务，对外统一提供服务
    ServiceAccount(): pod 中运行进程的 识别码
    shuffle sharding(): 一种将请求分配给队列的技术，比 对队列数取哈希模 有更好的 隔离性
    StatefulSet(状态集): 用于管理一组 pod 的部署和扩展，并保证这些 pod 的唯一性 和 有序性
    Static Pod(静态豌豆荚): 指定 node 上，被 kubelet 直接管理的 pod 
    Taint(感染): 用于阻止 scheduler 对 pod 的进行调度
    Toleration(容忍): 允许匹配 Taint 的 pod 进行调度
    UID(唯一识别码): 
    Volume(卷): 
    Workload(工作负荷): 
    
        
Node:
    kubelet 会自动将自身添加到 kube-apiserver 中
    
    Status：
        Address:
            HostName: 
            ExternalIP: 可在 集群 外部 路由的 IP
            InternalIP: 仅在 集群 内部 路由的 IP
        Condition:
            Ready:
            DiskPressure:
            MemoryPressure:
            PIDPressure:
            NetworkUnavailable:
            SchedulingDisabled: 当查看一个 cordoned(封锁，镇压) Node 的状态时，有这个属性
        Capacity and Allocatable: 描述 Node 上可用的资源
        Info: 描述 Node 内核信息，k8s 版本等
    Heartbeats: 
        模式 1：主动更新 Node 的 .status
        模式 2：在 kube-node-lease namespace 中 租赁 对象的方式(轻量，对性能影响较少)


    
    
