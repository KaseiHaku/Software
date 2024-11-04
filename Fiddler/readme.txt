官网：https://www.telerik.com/fiddler  
下载 Fiddler Classic，别选 Fiddler Everywhere(要钱)

################################ 安装 CA Root 证书 ################################

安装 CA Root 证书 {
    Tools -> Options... -> HTTPS 
          -> [勾选] Decypt HTTPS Traffic 
          -> Actions -> Trust Root Certificate
          -> Trusted Root Certification Authorities        # 安装证书到该位置，一定要选择 Local Machine 而不是 Current User
    

}




