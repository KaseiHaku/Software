Introduce:
    catalina.out                                # Tomcat 自身 stdout 和 stderr 目标文件
    catalina.YYYY-MM-DD.log                     # Tomcat 自己运行的一些日志，主要记录 Tomcat 在启动和暂停时的运行内容
    localhost.YYYY-MM-DD.log                    # 主要是应用初始化(listener, filter, servlet)未处理的异常最后被 Tomcat 捕获而输出的日志
    localhost_access_log.YYYY-MM-DD.txt         # Tomcat 的请求访问日志，请求的时间，请求的类型，请求的资源和返回的状态码都有记录。

@Caveats    
    Tomcat 默认配置不支持 PUT，DELETE 方法，需要在 %TOMCAT_HOME%/conf/web.xml 文件中配置 servlet 初始化参数 readonly= false
    即:
    <servlet>
        <servlet-name>default</servlet-name>
        <servlet-class>org.apache.catalina.servlets.DefaultServlet</servlet-class>
        <init-param>
            <param-name>debug</param-name>
            <param-value>0</param-value>
        </init-param>
        <init-param>
            <param-name>readonly</param-name>
            <param-value>false</param-value> <!-- 这里设置成 false，没有该配置，默认为 true -->
        </init-param>
        <init-param>
            <param-name>listings</param-name>
            <param-value>false</param-value>
        </init-param>
        <load-on-startup>1</load-on-startup>
    </servlet>
