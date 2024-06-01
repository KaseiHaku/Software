Install:
    shell> docker pull sonatype/nexus3

Concept:
    Repo 
        Format:
            maven      
            npm
            docker     docker iamge 仓库
            helm       k8s 预配置库
        Type:
            host:      本地私有仓库  
            proxy:     其他仓库的代理仓库   
            group:     聚合多个 host/proxy 并提供统一的访问 URL


Configure:
    创建一个名为 "nx-publisher" 的 Role，并分配所有 repo 的 add 权限
    创建一个名为 "publisher" 的 User，设置该用户密码为 "0b493cfe-9712-46d1-88c8-58262ea9af8c"，并分配 "nx-publisher" Role 给该用户
