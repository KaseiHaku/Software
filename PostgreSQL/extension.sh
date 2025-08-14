################################ pgsql 安装插件 ################################ 



################ 包管理器安装
######## Debian/Ubuntu
shell> sudo apt-get update
shell> sudo apt-get install postgresql-<version>-<plugin-name>
shell> sudo apt-get install postgresql-14-postgis          # 安装 gis(地理空间数据) 插件
######## RHEL/CentOS
shell> sudo yum install postgresql<version>-<plugin-name>
shell> sudo dnf install postgresql<version>-<plugin-name>

################ 从源码编译安装
shell> cd /path/to/plugin
shell> make
shell> sudo make install

################ 手动安装扩展
shell> sudo cp plugin.so /usr/lib/postgresql/<version>/lib/      # 将插件文件(.so)复制到PostgreSQL的lib目录
sql> CREATE EXTENSION <extension_name>;                          # 在数据库中创建扩展

