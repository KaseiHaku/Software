-- Database
-- 必须登录 system 数据库执行以下 Cypher ，system 数据库是保存 Neo4j 数据库服务程序本身数据的库
-- 只支持 enterprise 版
show databases                  -- 查看所有数据库
show default database           -- 查看 Neo4j DBMS 默认连接的数据库
show database dbName            -- 查看指定数据库的状态及信息
stop database dbName            -- 关闭指定数据库
start database dbName           -- 启动指定数据库
create database dbName          -- 创建指定数据库，dbName 规则：[a..z][0..9]
drop database dbName            -- 删除指定数据库


:use dbName                     -- 切换当前使用的数据库
