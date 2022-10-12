################################ KinD ################################

# 使用 kind 创建一个 cluster
shell> kind create cluster --config=kind-cluster-config.yml   # kind 通过该配置文件创建 cluster
                           --kubeconfig=~/.kube/config      # kubectl 命令行工具使用 kubeconfig 文件来查找选择集群所需的信息，并与集群的 API 服务器进行通信
                           --image=kindest/node:v1.15.3     # 指定 kind 使用的 image 的版本
                           --name clusterName       # 指定集群名称，默认为: kind
                           
# kind 查看集群信息
shell> kind get clusters            # 查看当前集群有哪些
shell> kind get nodes
shell> kind get kubeconfig

# kind 删除集群
shell> kind delete cluster  --name=clusterName  # 删除指定集群    
shell> kind delete clusters --all       # 删除所有集群


# kind 加载 自建镜像
shell> kind load docker-image kasei/demo:0.0.1     # 加载 docker image 到集群中，坑:加载的 image 必须具有明确的 tag，不能是 latest,否则加载不了
shell> kind load image-archive image.tar            # 通过 image 文件加载 镜像
shell> docker exec -it controlPlaneContainer crictl images      # 查看当前集群中的所有 image


# 配置使用 Local Private Registry
# 1. 修改 kind 配置
# 2. 添加 ConfigMap
# 3. 运行 registry 镜像
# 4. 配置 secret 




# 配置 k8s 使用私有镜像库
# @help https://kubernetes.io/docs/concepts/containers/images/#using-a-private-registry
# 方式一：
# kubelet 依次检查以下文件，在以下文件中找到 私有仓库 地址
#   {--root-dir:-/var/lib/kubelet}/config.json
#   {cwd of kubelet}/config.json
#   ${HOME}/.docker/config.json
#   /.docker/config.json
#   {--root-dir:-/var/lib/kubelet}/.dockercfg
#   {cwd of kubelet}/.dockercfg
#   ${HOME}/.dockercfg
#   /.dockercfg
shell> docker login localhost:5000      # 该命令会在 $HOME/.docker/config.json 新增一个私有仓库配置
shell> vim $HOME/.docker/config.json    # 编辑该文件，删掉不要的
shell> # 将编辑后的文件复制到所有 node 的上述目录中去，有管理工具，可以批量处理
# 方式二：预先加载 image 到 node 中，不推荐
# 方式三：Pod 中指定 imagePullSecrets，推荐


# 配置 ingress controller
shell> kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

# 配置 Telepresence 用于本地开发调试
shell> sudo curl -fL https://app.getambassador.io/download/tel2/linux/amd64/latest/telepresence -o /usr/local/bin/telepresence
shell> sudo chmod a+x /usr/local/bin/telepresence

# Telepresence 创建拦截器 
shell> telepresence intercept serviceName --http-match=all --namespace ns1    # 在指定的 namespace 中创建 global intercept，拦截所有 http 请求
shell> telepresence intercept serviceName --http-match=HeadName=val             # 只拦截 http request header 匹配的请求
                                          --http-path-equal <path>              # 用于在 --http-match 的基础上，仅拦截指定路径，--htt-path-* 最多只能有一个
                                          --http-path-prefix <prefix>           # 用于在 --http-match 的基础上，仅拦截指定前缀的路径
                                          --http-path-regex <regex>             # 用于在 --http-match 的基础上，仅拦截符合 regex 的路径



################################ kubectl ################################
# 管理 K8s 对象的技术：
# @doc https://kubernetes.io/docs/tasks/manage-kubernetes-objects/
#   指令式命令：
#       即: shell> kubectl create deployment nginx --image nginx     # 命令行参数模式
#   指令式对象配置：
#       即: shell> kubectl create -f xxx.yml           # 配置文件方式
#   声明式对象配置：
#       即: shell> kubectl patch -f patch.yml          # 初次使用 配置文件方式，后续修改使用 补丁文件
#       shell> kubectl kustomize <kustomization_directory>      # 使用 kustomization.yaml 来管理，kustomize 属于 声明式对象配置 的一种

shell> kubectl cluster-info --context kind-kind     # 查看指定集群信息，--context 指定集群名称
shell> kubectl get pods -A -o wide
shell> kubectl -n namespace get pods -o yaml
shell> kubectl describe pod POD
shell> kubectl logs
shell> kubectl debug 
shell> kubectl -n ns exec POD -c containerName -i -t -- /bin/bash 
shell> kubectl -n ns exec TYPE/NAME -c containerName -i -t -- /bin/bash 


shell> kubectl apply -f dir/            # 应用 dir 目录下的所有 yml 对应的 k8s 对象
shell> kubectl delete -f dir/            # 应用 dir 目录下的所有 yml 对应的 k8s 对象

# 自定义输出格式
# @doc https://kubernetes.io/docs/reference/kubectl/overview/#custom-columns
shell> kubectl -n namespace get pods podName -o 'custom-columns=NAME:.metadata.name,RSRC:.metadata.resourceVersion'
# @doc http://golang.org/pkg/text/template/#pkg-overview
shell> kubectl -n namespace get pods podName -o 'go-template='
# @doc https://kubernetes.io/docs/reference/kubectl/jsonpath/
shell> kubectl -n namespace get pods podName -o 'jsonpath={}'



    shell> kubectl api-resources | grep true | awk -- '{print $1}' | xargs -rti kubectl -n xxx get {}       # 查看命名空间下所有资源
    shell> kubectl -n xxx delete all --all      # 删除某一命名空间下所有东西
    

#### 从 Pod 里面复制文件，或复制文件到 Pod 里面, 
# @trap shell> kubectl cp ;   要求容器中有 tar 命令
# @trap 如果要保留 symlinks, 执行 * 展开，文件 mode 保留，那么使用 shell> kubectl exec

shell> kubectl cp /tmp/foo_dir <some-pod>:/tmp/bar_dir                          # 将本地 /tmp/foo_dir 复制到 default 命名空间中 <some-pod>
shell> kubectl cp /tmp/foo_dir <some-pod>:/tmp/bar_dir -c <specific-container>  # 将本地 /tmp/foo_dir 复制到 default 命名空间中 <some-pod> 中的指定 container
shell> kubectl cp /tmp/foo_dir <some-namespace>/<some-pod>:/tmp/bar_dir         # 将本地 /tmp/foo_dir 复制到 <some-namespace> 命名空间中 <some-pod> 中的指定 container
shell> kubectl cp <some-namespace>/<some-pod>:/tmp/foo_dir /tmp/bar_dir         # 将 <some-namespace> 命名空间 <some-pod> Pod 中的 /tmp/foo 复制到本地 /tmp/bar


shell> tar cf - /tmp/foo | kubectl exec -i -n <some-namespace> <some-pod> -- tar xf - -C /tmp/bar           # 复制本地 /tmp/foo 到远程 /tmp/bar
shell> kubectl exec -n <some-namespace> <some-pod> -- tar -czf - -C /tmp/foo test | tar xf - -C /tmp/bar    # 复制远程 /tmp/foo 目录下的 test 到本地 /tmp/bar
shell> kubectl exec -n <some-namespace> <some-pod> -- tar -czf - -C /blade/develop/ test > test.tar.gz      # 复制远程 /tmp/foo 目录下的 test 到本地 test.tar.gz


