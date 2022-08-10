节点调度配置方法有:
    Pod.spec.nodeName: 直接指定 调度 到指定 node 上
    Pod.spec.nodeSelector: 调度到匹配的 node labels 的 node 上
    affinity and anti-affinity: 
        亲和性，即: 偏向于调度到哪些 node 上，如果没有，那么调度到其他 node 上也没关系
        反亲和性: 即: 最好不调度到哪些 node 上，如果没有，那么调度这些 node 上也没关系
    Pod.spec.topologySpreadConstraints:
        pod 拓扑结构
    Pod.spec.tolerations:
        不调度到具有指定 taint 的 node 上
    
