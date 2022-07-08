# @doc https://helm.sh/docs/intro/quickstart/

# Concept：
#   Chart: Helm 中的软件包
#   Release: 已经安装的软件包，通过 helm install 第一次安装后，release 版本的版本号为 1. 每次发布 release 升级或回滚时，版本号都会增加
#   Tiller: Helm 服务器，是和 k8s 沟通的组件


# Install
# 下载地址：https://github.com/helm/helm/releases
shell> curl -O https://github.com/helm/helm/releases/xxx/helm-v3.8.2-linux-amd64.tar.gz 
shell> tar -zxvf helm-v3.8.2-linux-amd64.tar.gz 
shell> ln -s -T /xxx/linux-amd64/helm /usr/local/bin/helm    # 创建 软连接

# 配置仓库地址
shell> helm repo add bitnami https://charts.bitnami.com/bitnami


# 使用
shell> helm help
shell> helm help list
shell> helm list -h                 # 帮助

shell> helm repo update             # 获取仓库中最新的数据
shell> helm search repo bitnami     # 查找 chart
shell> helm install bitnami/mysql --generate-name --version ^2.0.0     # 安装 2.0.0 朝上的 软件包
shell> helm list    # 查看通过 helm 安装的软包的 release
shell> helm uninstall mysql-1612624192      # 卸载软件包
shell> helm status mysql-1612624192     # 查看软件包状态

# 自定义安装参数
shell> helm show values bitnami/wordpress       # 查看 wordpress Chart 的所有可配置参数

# 自定义安装参数：方法一
shell> cat <<EOF | tee ./values.yaml
mariadb:
  auth:
    database: user0db
    username: user0
EOF
shell> helm install -f values.yaml bitnami/wordpress --generate-name        # 使用 values.yaml 文件中的值，替换默认配置参数

# 自定义安装参数：方法二
shell> helm install  bitnami/wordpress --generate-name \
            --set mariadb.auth.database=user0db 
            --set mariadb.auth.username=user0
            --set a=b,c=d               # 等价于两个 --set
            --set name={a, b, c}        # 等价于 name = 数组
            --set name=[],a=null        # 配置 空数组 和 null
            --set servers[0].port=80    # 配置 数组第 0 个元素的 port 属性的值
            --set name=value1\,value2   # name: "value1,value2"
            --set nodeSelector."kubernetes\.io/role"=master     # 引号中的是一整个字段名（属性名）
            
# 通过 --set 配置的安装参数会持久化到 ConfigMap 中
shell> helm get values <release-name>           # 可以查看通过 --set 配置是所有 安装参数
shell> helm upgrade --reset-values              # 重置安装参数

# 安装 Chart 的方式
shell> helm install releaseName chartName
shell> helm install foo foo-0.1.1.tgz       # 从本地 tar 包中安装
shell> helm install foo path/to/foo         # 从本地没有打包的目录中安装
shell> helm install foo https://example.com/charts/foo-1.2.3.tgz    # 通过完整的 url 安装













