################################ Install under CentOS 7
1. 配置 google 仓库源
    shell> cd /etc/yum.repos.d                             # 调整工作目录
    shell> touch ./google-chrome.repo                      # 创建新文件 google-chrome.repo
    shell> vim google-chrome.repo
    添加以下内容：
    [google-chrome]
    name=google-chrome
    baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64
    enabled=1
    gpgcheck=1
    gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
    保存

2. 检查仓库源是否生效
    shell> yum list |grep chrome  # 查看 yum 源中是否存在 chrome rpm 包，有则安装
    shell> yum install google-chrome-stable                # yum 安装即可，由于 Google 官方源在国内可能无法访问，请采用下一条命令
    shell> yum install google-chrome-stable --nogpgcheck

################################ Install under Ubuntu 18.04
1. 配置 google-chrome 的软件仓库
    shell> cd /etc/apt/sources.list.d/
    shell> touch google.list
    shell> vim google.list
    添加如下一行：
    deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main
    保存
    

2. 下载密钥
    shell> wget https://dl.google.com/linux/linux_signing_key.pub
    
3. 安装密钥
    shell> apt-key add linux_signing_key.pub
    
4. 更新软件包列表
    shell> apt-get update

5. 安装 chrome
    shell> apt-get install google-chrome-stable

6. 运行
    shell> google-chrome-stable










