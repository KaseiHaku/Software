1. 官网下载文件
    instantclient-basic-windows.x64-18.3.0.0.0dbru.zip      rem 基础连接包
    instantclient-sqlplus-windows.x64-18.3.0.0.0dbru.zip    rem sqlplus 命令包

2. 解压
    解压第一个文件，得到 instantclient_18_3 文件夹
    解压第二个文件，得到 instantclient_18_3 文件夹，把第二个解压出来的文件夹中的内容全部复制到第一个文件夹中去

3. 配置环境变量
    ORACLE_HOME = F:/InstantClient/instantclient_18_3               rem oci.dll 文件所在的目录
    PATH = %ORACLE_HOME%;                                           rem 追加
    TNS_ADMIN = %ORACLE_HOME%                                       rem 配置为 tnsnames.ora 文件所在的目录
    NLS_LANG = SIMPLIFIED CHINESE_CHINA.ZHS16GBK                    rem 设置客户端语言环境
    
4. 创建必要的文件： tnsnames.ora, sqlnet.ora, oraaccess.xml
    在 %ORACLE_HOME% 下创建这三个文件，并修改其中的内容，具体内容在当前目录下的样板文件里
    
   
    
rem sql 连接 URL 格式
shell> sqlplus username/password@192.168.0.1:1521/oracleSID:server/instanceName    

