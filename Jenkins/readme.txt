Concept:
    Folder: 文件夹，可以对 Job 进行分组，不同的组有不同的 命名空间，而 View 仅仅是一个过滤器，所以 不同 View 中的 Job name 不能一样，而 Folder 可以
    View: Job 的一个展示视图
    Job: 一个构建任务，可以是： pipeline, freestyle, ...

Correlation Path:
    /usr/lib/jenkins/               # jenkins 安装目录
    /var/lib/jenkins/               # 默认 JENKINS_HOME
    /etc/sysconfig/jenkins          # jenkins 配置文件路径
    /var/log/jenkins/jenkins.log    # jenkins 日志文件




NodeJS:
    func: 使用不同的 nodejs 版本，构建项目
    
    # Configuration
    Manage Jenkins -> Manage Plugins -> 找到 NodeJS 插件安装
    Manage Jenkins -> Global Tool Configuration -> Node -> 全局工具名称，方便在 pipeline 中引入  -> 配置是否自动安装
    Manage Jenkins -> Configure System -> Global properties -> 添加环境变量 PATH=$PATH:/var/jenkins_home/tools/jenkins.plugins.nodejs.tools.NodeJSInstallation/node/bin
    
    # NewItem & Pipeline
    Dashboard -> New Item -> Freestlye project -> Build Environment -> [勾选] Provide Node & npm bin/ folder to PATH -> 才行    
    Dashboard -> New Item -> Pipeline -> Jenkinsfile 脚本中需要添加 tools { nodejs 'globalToolName' } 块才行


GitSCM:
    func: 从不同的仓库中下载源码到 workspace 指定目录下
    
    # Configuration
    Manage Jenkins -> Manage Plugins -> 找到 GitSCM 插件安装
    Manage Jenkins -> Global Tool Configuration -> Git -> 全局工具名称，方便在 pipeline 中引入  -> 配置是否自动安装
    
    # NewItem & Pipeline
    Dashboard -> New Item -> Pipeline -> Jenkinsfile 脚本中需要添加 tools { git 'globalToolName' } 块才行

Publish Over SSH:
    func: 将 artificate 发送到远程
    
    # Configuration
    Manage Jenkins -> Manage Plugins -> 找到 Publish Over SSH 插件安装
    Manage Jenkins -> Configure System -> Publish over SSH -> SSH Servers -> 配置 server name，host，username, remote directory
    Dashboard -> New Item -> Pipeline -> steps 中添加 sshPublisher( publishers: [] )

Build Timeout:
    func: 构建时间超时直接结束构建
        

