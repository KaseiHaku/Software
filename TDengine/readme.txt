Concept:
    Data Collection Point(DCP): 数据采集点
    Metric: 指标，随着时间的改变而改变
    Label/Tag: 标签，数据采集点 的静态标识，不随时间改变而改变
    Table: 常规表，
    Subtable: 子表，设计原则 一个数据采集点一张表，使用 DCP id 作为表名后缀
    Super Table(STable): 超级表，同类型的数据采集点具有相同的 schema，可以使用 超级表 进行聚合分析操作
    Database: 多个表的集合
    FQDN (Fully Qualified Domain Name): 域名
    End Point: TDengine cluster 中用于唯一标识一个 node 的字符串

Frequently Used:
    Database:
        # 创建数据库
        # 可用参数文档： https://docs.tdengine.com/taos-sql/database/
        CREATE DATABASE power KEEP 365 DAYS 10 BLOCKS 6 UPDATE 1;
    
    STable:
        # 创建超级表
        CREATE STable meters (ts timestamp, current float, voltage int, phase float) TAGS (location binary(64), groupId int);
        
        
