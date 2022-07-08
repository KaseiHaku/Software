工具介绍:
    kubectl：k8s 命令行工具
    kind: 允许在 本机 上运行 k8s，需要先安装 docker 
    minikube: 和 kind 类似，只是运行一个 单节点的 k8s 集群
    kubeadm: 用于创建和管理 k8s 集群，生产环境使用

kubectl 安装:
    集群默认访问的配置文件: ~/.kube/config
    
    shell> mkdir -p /opt/kubernetes && cd /opt/kubernetes
    shell> curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    shell> chmod +x kubectl
    # 将执行文件放到 PATH 目录中
    shell> sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    shell> ln -sT /opt/kubernetes/kubectl /usr/local/bin/kubectl

kind 安装：
    shell> mkdir -p /opt/kubernetes && cd /opt/kubernetes
    shell> curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.11.1/kind-linux-amd64
    shell> chmod +x ./kind
    shell> ln -sT /opt/kubernetes/kind /usr/local/bin/kind
    
    
    

