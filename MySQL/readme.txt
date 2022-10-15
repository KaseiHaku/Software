mysql 命令行 多行 sql 取消:
    mysql> select 123 from
        -> dual
        -> \c       -- 取消上面所有输入

MySQL self synopsis:
    mysql> show version;
    mysql> show global variables where variable like '%a%';
    mysql> select t.* from performance_schema.global_variables t; -- 变量
    mysql> show variables where variable like '%a%';
    mysql> show variables like 'character%';    -- 查看编字符编码方式
    mysql> show variables like 'collation%';    -- 查看排序方式
    mysql> show databases;
    mysql> show tables; 
    mysql> show create table tb1;      -- 查看一个表的 DDL

Buildin Schema:
    information_schema          提供了访问数据库元数据的方式
    mysql                       核心数据库，主要负责存储数据库的用户、权限设置、关键字等
    performance_schema          主要用于收集数据库服务器性能参数
    sys                         sys 库所有的数据源来自：performance_schema。目标是把performance_schema的把复杂度降低，让DBA能更好的阅读这个库里的内容

CharacterSet Introduce:
    mysql> show character set;  -- 查看所有支持的字符集
    utf8            仅支持基本的 unicode
    utf8mb4         支持最新的 unicode 推荐使用

Collation: 排序规则: _ci(大小写不敏感), _cs(大小写敏感), _bin(表示用编码值进行比较)
    mysql> show collation where charset='utf8mb4';  -- 推荐使用 utf8mb4_unicode_ci 排序方式


部署方式：
    复制方式：
        binlog + position
        GTID:
            最好是 RBR 格式
    binlog 格式：
        SBR: statement-based replication
        RBR: row-based replication
        MIXED: 混合模式
        
        异步复制
        半同步复制，必须是 AFTER_SYNC

    基础：
        主从模式 + 半同步复制
    进阶:
        双通道复制
        binlog 文件服务器，需要改源码
    killing spree:
        MHA+多节点集群
        zookeeper+proxy
        
    dominating:
        SAN共享储存
        DRBD磁盘复制
    unstoppable:
    
    godlike:
        
    legendary：
        MySQL cluster
        Galera
        POAXS
