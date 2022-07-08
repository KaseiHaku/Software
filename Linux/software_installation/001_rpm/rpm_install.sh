# rpm 安装： 
# 依赖问题    层级依赖： 先安装上层软件包；    环形依赖： 所有软件包同时安装

shell> rpm -?                               # 查看帮助
shell> rpm --usage                          # 查看简单的用法

shell> rpm -qa | grep 'tomcat'              # 查看系统所有采用 rpm 安装的软件
shell> rpm -qf file                         # 查看一个文件属于哪个软件包
shell> rpm -ql tomcat                       # 查看已安装软件的安装位置
shell> rpm -qd tomcat                       # 查看已安装软件的安装文档的位置
shell> rpm -qc tomcat                       # 查看已安装软件的配置文件
shell> rpm -qR tomcat                       # 查看已安装软件所依赖的包和文件


shell> rpm -i tomcat                        # 安装软件包

shell> rpm -iv tomcat                       # 显示详细的安装过程


shell> rpm -U tomcat.rpm                    # 升级 tomcat.rpm 包

shell> rpm --import 签名文件                 # 导入签名文件


shell> rpm -e tomcat                        # 卸载软件包
shell> rpm -e tomcat --nodeps               # 删除 tomcat 包对应的软件，不管依赖关系

