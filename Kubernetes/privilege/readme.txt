相关资源：
    @doc https://kubernetes.io/docs/reference/access-authn-authz/rbac/
 
RBAC Authorization (Access to the Kubernetes API):
    User:
        ServiceAccount:
    
    
    Group:
    
    Role:
        Role: 表示一组权限的集合，全是添加权限，没有禁用规则。必须指定 namespace
        ClusterRole: 同上，但是不指定 namespace
            Scenario: 
                定义 具有命名空间的资源 的权限，并在 单个命名空间 内 授予权限
                定义 具有命名空间的资源 的权限，并在 所有命名空间 上 授予权限
                定义 集群范围资源 的权限
    Privilege:
        RoleBinding: 授予权限给 user 或 一组 user。必须指定 namespace
        ClusterRoleBinding: 同上，但是不指定 namespace
    
    
    


                     
                     
                     
