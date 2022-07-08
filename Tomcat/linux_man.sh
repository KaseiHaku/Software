function tomcatInstallation(){
    #1. 检查系统中是否已经安装 tomcat
    rpm -qa |grep tomcat
    yum list installed |grep tomcat
    
    #2. 如果已经安装 tomcat 那么卸载
    rpm -e *tomcat*
    yum -y remove *tomcat*
    
    #3. 官网下载 apache-tomcat-9.0.7.tar.gz
    #4. 解压拆包
    tar -zxvf apache-tomcat-9.0.7.tar.gz
    
    #5. 创建目录 /usr/tomcat ，并将解压拆包后的文件移动到该目录下
    mkdir /usr/tomcat
    mv ./apache-tomcat-9.0.7 /usr/tomcat
    
    #6. 配置环境变量
    vi /etc/profile
    
    export CATALINA_HOME=/usr/tomcat/apache-tomcat-9.0.7    
    PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin:$CATALINA_HOME/bin
    
    #7. 启动 tomcat
    /usr/tomcat/apache-tomcat-9.0.7/bin/startup.sh
    
    #8. 浏览器中输入 localhost:8080 是否出现 tomcat 页面，出现则安装成功
}





