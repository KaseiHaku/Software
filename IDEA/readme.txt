Download {
    https://www.jetbrains.com/idea/download/other.html      # 历史版本下载，需要下载 带 JBR 的版本，否则界面不好看

}


IntelliJ IDEA Concept and Architecture {

    坑：工程创建之前保证所有必要的 plugin 都已经加载，File -> Settings -> Plugins -> 右侧窗口中所有 plugin 都应该加载

	Project     =>  项目，工程；相当于 Eclipse 中的 workspace
	
	Module      =>  模块；相当于 Eclipse 中的 project
	
	Libraries   =>  当前项目依赖的 jar 包库
	
	Facets      =>  英文解释：某一方面；对于项目来说就是 “特征，特征面”
	            =>  表示当前项目具有哪些特征，如：Hibernate Spring Web 等
	            
	Artifacts   =>  英文解释：手工制品；对于项目来说就是 “产物，产品”
	            =>  表示当前 Module 要怎么打包，例如 war exploded、war、jar 打包形式；Module 打包后才能部署到服务器
	            
	项目路径结构：
    project：项目名称，相当于 eclipse 中的 workspace
    module：组件模块名称，相当于 eclipse 中的 project
    
    IDEA : e:/IdeaProjects/project_name/module_name
    Eclipse: e:/WorkSpace/projcet  
}


必备插件 {
    lombok                          # JavaBean 方法自动生成
    call graph                      
    sequence diagram                    
    vue.js                          # 识别 .vue 文件
    ide eval reset                  # idea 破解
    MyBatis Log Free                # 拼接好 mybatis 中的 sql 和 param，用于直接在 sql 工具执行
    MyBatisX                        # XxxMapper.java 和 XxxMapper.xml 之间跳转
    MyBatisCodeHelperPro            # 写 sql 提示
    EnvFile                         # 配合 K8S 设置环境变量
    Kubernetes                      # K8s 配置文件提示
    HTTP Client                     # http 客户端工具
    RestfulTool                     # Spring MVC/Boot Controller 搜索
    Graph Database support          # neo4j，识别 .cyp, .cypher, .cql 文件
    
    # 代码规范
    CheckStyle-IDEA                 # 格式规范，作为 SonarLint 的补充
    SonarLint                       # 代码规范，推荐
    Alibaba Java Coding Guidelines  # 代码规范
    
    # AI code
    Codota                          # sunsetting, 被 tabnine 替代
    Tabnine AI Code Completion      # 基于 GPT-2 本地学习，偏向于代码补全
    GitHub Copilot                  # 基于 github 代码学习，偏向于功能猜测，要钱
    
}




Crack {  
    激活码： 
BISACXYELK-eyJsaWNlbnNlSWQiOiJCSVNBQ1hZRUxLIiwibGljZW5zZWVOYW1lIjoiQ2hpbmFOQiIsImFzc2lnbmVlTmFtZSI6IiIsImFzc2lnbmVlRW1haWwiOiIiLCJsaWNlbnNlUmVzdHJpY3Rpb24iOiIiLCJjaGVja0NvbmN1cnJlbnRVc2UiOmZhbHNlLCJwcm9kdWN0cyI6W3siY29kZSI6IklJIiwicGFpZFVwVG8iOiIyMDk5LTEyLTMxIiwiZXh0ZW5kZWQiOmZhbHNlfSx7ImNvZGUiOiJBQyIsInBhaWRVcFRvIjoiMjA5OS0xMi0zMSIsImV4dGVuZGVkIjpmYWxzZX0seyJjb2RlIjoiRFBOIiwicGFpZFVwVG8iOiIyMDk5LTEyLTMxIiwiZXh0ZW5kZWQiOnRydWV9LHsiY29kZSI6IlJTQyIsInBhaWRVcFRvIjoiMjA5OS0xMi0zMSIsImV4dGVuZGVkIjp0cnVlfSx7ImNvZGUiOiJQUyIsInBhaWRVcFRvIjoiMjA5OS0xMi0zMSIsImV4dGVuZGVkIjpmYWxzZX0seyJjb2RlIjoiUlNGIiwicGFpZFVwVG8iOiIyMDk5LTEyLTMxIiwiZXh0ZW5kZWQiOnRydWV9LHsiY29kZSI6IkdPIiwicGFpZFVwVG8iOiIyMDk5LTEyLTMxIiwiZXh0ZW5kZWQiOmZhbHNlfSx7ImNvZGUiOiJETSIsInBhaWRVcFRvIjoiMjA5OS0xMi0zMSIsImV4dGVuZGVkIjp0cnVlfSx7ImNvZGUiOiJDTCIsInBhaWRVcFRvIjoiMjA5OS0xMi0zMSIsImV4dGVuZGVkIjpmYWxzZX0seyJjb2RlIjoiUlMwIiwicGFpZFVwVG8iOiIyMDk5LTEyLTMxIiwiZXh0ZW5kZWQiOnRydWV9LHsiY29kZSI6IlJDIiwicGFpZFVwVG8iOiIyMDk5LTEyLTMxIiwiZXh0ZW5kZWQiOnRydWV9LHsiY29kZSI6IlJEIiwicGFpZFVwVG8iOiIyMDk5LTEyLTMxIiwiZXh0ZW5kZWQiOmZhbHNlfSx7ImNvZGUiOiJQQyIsInBhaWRVcFRvIjoiMjA5OS0xMi0zMSIsImV4dGVuZGVkIjpmYWxzZX0seyJjb2RlIjoiUlNWIiwicGFpZFVwVG8iOiIyMDk5LTEyLTMxIiwiZXh0ZW5kZWQiOnRydWV9LHsiY29kZSI6IlJTVSIsInBhaWRVcFRvIjoiMjA5OS0xMi0zMSIsImV4dGVuZGVkIjpmYWxzZX0seyJjb2RlIjoiUk0iLCJwYWlkVXBUbyI6IjIwOTktMTItMzEiLCJleHRlbmRlZCI6ZmFsc2V9LHsiY29kZSI6IldTIiwicGFpZFVwVG8iOiIyMDk5LTEyLTMxIiwiZXh0ZW5kZWQiOmZhbHNlfSx7ImNvZGUiOiJEQiIsInBhaWRVcFRvIjoiMjA5OS0xMi0zMSIsImV4dGVuZGVkIjpmYWxzZX0seyJjb2RlIjoiREMiLCJwYWlkVXBUbyI6IjIwOTktMTItMzEiLCJleHRlbmRlZCI6dHJ1ZX0seyJjb2RlIjoiUERCIiwicGFpZFVwVG8iOiIyMDk5LTEyLTMxIiwiZXh0ZW5kZWQiOnRydWV9LHsiY29kZSI6IlBXUyIsInBhaWRVcFRvIjoiMjA5OS0xMi0zMSIsImV4dGVuZGVkIjp0cnVlfSx7ImNvZGUiOiJQR08iLCJwYWlkVXBUbyI6IjIwOTktMTItMzEiLCJleHRlbmRlZCI6dHJ1ZX0seyJjb2RlIjoiUFBTIiwicGFpZFVwVG8iOiIyMDk5LTEyLTMxIiwiZXh0ZW5kZWQiOnRydWV9LHsiY29kZSI6IlBQQyIsInBhaWRVcFRvIjoiMjA5OS0xMi0zMSIsImV4dGVuZGVkIjp0cnVlfSx7ImNvZGUiOiJQUkIiLCJwYWlkVXBUbyI6IjIwOTktMTItMzEiLCJleHRlbmRlZCI6dHJ1ZX0seyJjb2RlIjoiUFNXIiwicGFpZFVwVG8iOiIyMDk5LTEyLTMxIiwiZXh0ZW5kZWQiOnRydWV9LHsiY29kZSI6IkRQIiwicGFpZFVwVG8iOiIyMDk5LTEyLTMxIiwiZXh0ZW5kZWQiOnRydWV9LHsiY29kZSI6IlJTIiwicGFpZFVwVG8iOiIyMDk5LTEyLTMxIiwiZXh0ZW5kZWQiOnRydWV9XSwibWV0YWRhdGEiOiIwMTIwMjAwNzI4RVBKQTAwODAwNiIsImhhc2giOiIxNTAyMTM1NC8wOi0xMjUxMTE0NzE3IiwiZ3JhY2VQZXJpb2REYXlzIjowLCJhdXRvUHJvbG9uZ2F0ZWQiOmZhbHNlLCJpc0F1dG9Qcm9sb25nYXRlZCI6ZmFsc2V9-H7NUmWcLyUNV1ctnlzc4P79j15qL56G0jeIYWPk/HViNdMg1MqPM7BR+aHR28yyuxK7Odb2bFDS8CeHNUtv7nT+4fUs85JJiqc3wc1psRpZq5R77apXLOmvmossWpbAw8T1hOGV9IPUm1f2O1+kLBxrOkdqPpv9+JanbdL7bvchAid2v4/dyQMBYJme/feZ0Dy2l7Jjpwno1TeblEAu0KZmarEo15or5RUNwtaGBL5+396TLhnw1qL904/uPnGftjxWYluLjabO/uRu/+5td8UA/39a1nvGU2nORNLk2IdRGIheiwIiuirAZrII9+OxB+p52i3TIv7ugtkw0E3Jpkw==-MIIDlzCCAn+gAwIBAgIBCTANBgkqhkiG9w0BAQsFADAYMRYwFAYDVQQDEw1KZXRQcm9maWxlIENBMCAXDTE4MTEwMTEyMjk0NloYDzIwOTkwODA5MDIyNjA3WjBoMQswCQYDVQQGEwJDWjEOMAwGA1UECBMFTnVzbGUxDzANBgNVBAcTBlByYWd1ZTEZMBcGA1UEChMQSmV0QnJhaW5zIHMuci5vLjEdMBsGA1UEAxMUcHJvZDN5LWZyb20tMjAxODExMDEwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCdXyaNhhRySH1a8d7c8SlLLFdNcQP8M3gNnq7gudcpHC651qxRrN7Qks8gdXlIkA4u3/lp9ylp95GiIIDo4ydYje8vlTWDq02bkyWW/G7gZ3hkbBhRUK/WnNyr2vwWoOgwx5CfTRMjKkPkfD/+jffkfNfdGmGcg9yfnqPP9/AizKzWTsXSeS+0jZ8Nw5tiYFW+lpceqlzwzKdTHug7Vs0QomUPccRtZB/TBBEuiC7YzrvLg4Amu0I48ETAcch/ztt00nx/oj/fu1DTnz4Iz4ilrNY+WVIEfDz/n3mz+PKI9kM+ZeB0jAuyLsiC7skGpIVGX/2HqmZTtJKBZCoveAiVAgMBAAGjgZkwgZYwSAYDVR0jBEEwP4AUo562SGdCEjZBvW3gubSgUouX8bOhHKQaMBgxFjAUBgNVBAMMDUpldFByb2ZpbGUgQ0GCCQDSbLGDsoN54TAJBgNVHRMEAjAAMBMGA1UdJQQMMAoGCCsGAQUFBwMBMAsGA1UdDwQEAwIFoDAdBgNVHQ4EFgQUYSkb2hkZx8swY0GRjtKAeIwaBNwwDQYJKoZIhvcNAQELBQADggEBAJZOakWgjfY359glviVffBQFxFS6C+4WjYDYzvzjWHUQoGBFKTHG4xUmTVW7y5GnPSvIlkaj49SzbD9KuiTc77GHyFCTwYMz+qITgbDg3/ao/x/be4DD/k/byWqW4Rb8OSYCshX/fNI4Xu+hxazh179taHX4NaH92ReLVyXNYsooq7mE5YhR9Qsiy35ORviQLrgFrMCGCxT9DWlFBuiPWIOqN544sL9OzFMz+bjqjCoAE/xfIJjI7H7SqGFNrx/8/IuF0hvZbO3bLIz+BOR1L2O+qT728wK6womnp2LLANTPbwu7nf39rpP182WW+xw2z9MKYwwMDwGR1iTYnD4/Sjw=



    jar 包破解:
        %IDEA_HOME%/bin/idea64.exe.vmoptions   添加一行
        C:\Users\Administrator\AppData\Roaming\JetBrains\IntelliJIdea2021.2\idea64.exe.vmoptions 添加一行
        -javaagent:/crackJarPath.jar
        
        @trap 该破解方式必须先进 IDEA 才行，所以必须先试用，如果已过试用期的，先调整系统时间到试用期内，然后进去 IDEA 才能破解

}

Preset {
    # 配置后台不自动更新
    File -> Settings -> Appearance & Behavior -> System Settings -> Updates -> [不勾选] Automatically check updates for [...]

    # 配置一个不存在的代理，防止 IDEA 自动请求远程服务器导致 激活码 失效
    File -> Settings -> Appearance & Behavior -> System Settings -> Http Proxy -> Manual proxy configuration
    -> [勾选] Socks
    -> Host name: 127.0.0.1
    -> Port number: 10000
    -> No proxy for: localhost,127.*,192.168.*
    

    # Intellij IDEA 2020.2.4 插件仓库破解
    File -> Settings -> Plugins -> Manage Plugins Reposito 
    -> 添加仓库地址 
        https://repo.idechajian.com
    -> 搜索插件 "BetterIntellij" 并安装
    Help -> Register... -> Add New License -> Active Code -> 粘贴上述激活码即可（无前后空格） -> 激活即可 
    -> 如果不行打开 idea64.exe.vmoptions 文件看看，删掉多余的，还不行 shell> find /  删除掉所有 IDEA 的配置文件及目录
     
    # Intellij IDEA 2020.2.4 无限试用
     File -> Settings -> Plugins -> Manage Plugins Reposito 
    -> 添加仓库地址 
        https://plugins.zhile.io
    -> 搜索插件 "IDE Eval Reset" 并安装
    -> 重启 IDEA  
    -> Help -> Eval Reset 重置试用时间
    
}





