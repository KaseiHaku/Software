# download and install
shell> wget apache-zookeeper-3.6.2-bin.tar.gz
shell> tar -zxf apache-zookeeper-3.6.2-bin.tar.gz
shell> cd apache-zookeeper-3.6.2-bin        # 该目录就是 ZOOKEEPER_HOME


# config
shell> cd conf          
shell> cp ./zoo_sample.cfg zoo.cfg          # 直接使用 样板文件


# start
shell> cd $ZOOKEEPER_HOME/bin
shell> ./zkServer.sh start          # 启动 zookeeper 服务

# start client
shell> ./zkCli.sh 
zk> help             # 查看命令列表


# stop 
shell> cd $ZOOKEEPER_HOME/bin
shell> ./zkServer.sh stop          # 启动 zookeeper 服务

