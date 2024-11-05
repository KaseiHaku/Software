官网：https://www.telerik.com/fiddler  
下载 Fiddler Classic，别选 Fiddler Everywhere(要钱)

################################ 安装 CA Root 证书 ################################
运行：{
    @trap 必须使用 Run as administrator 启动
}



安装 CA Root 证书 {
    Tools -> Options... -> HTTPS 
          -> [勾选] Decypt HTTPS Traffic 
          -> Actions -> Trust Root Certificate
          -> Trusted Root Certification Authorities        # 安装证书到该位置，一定要选择 Local Machine 而不是 Current User
}


关闭默认开启的系统代理: {
    由于默认会开启 windows 系统代理，所以使用 Proxifier 时，建议关闭系统代理
    Tools -> Options... -> Connections 
          -> [不勾选] Act as system proxy on start up 

    @tips 实际 系统代理 是否开启可以进入
        Start -> Settings -> Network & Internet -> Proxy -> Manual proxy setup
              - 查看 use a proxy server 按钮是否开启来判断
}


Adroid 抓包配置: {
    Tools -> Options... 
        -> Connections 
            -> [不勾选] Act as system proxy on start up 
            -> [勾选] Allow remote computers to connect
        -> HTTPS 
            -> [勾选] Decypt HTTPS Traffic 
            -> [勾选] Ignore server certificate errors (unsafe)
            -> [不勾选] Check for certificate revocation
}

