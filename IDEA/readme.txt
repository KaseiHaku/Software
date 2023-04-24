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
    GitHub Copilot                  # 基于 github 代码学习，偏向于功能猜测
    
}
