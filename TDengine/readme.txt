Concept:
    Data Collection Point(DCP): 数据采集点
    Metric: 指标，随着时间的改变而改变
    Label/Tag: 标签，数据采集点 的静态标识，不随时间改变而改变
    Table: 常规表，
    Sub Table: 子表，设计原则 一个数据采集点一张表，使用 DCP id 作为表名后缀
    Super Table(STable): 超级表，同类型的数据采集点具有相同的 schema，可以使用 超级表 进行聚合分析操作
    Database: 多个表的集合
    FQDN (Fully Qualified Domain Name): 域名
    End Point: TDengine cluster 中用于唯一标识一个 node 的字符串
    Continuous Query: 连续查询，指指定时间间隔 或者 滑动窗口 自动执行的 query，查询结果会返回给 client 或者 重新写入到 tdengine 里面

    dnode: tdengine 集群数据节点
    mnode: tdengine 集群主节点
    vnode：虚拟节点，可以分布在各个 dnode 上，一个 DB 可以有多个 vnode，一个 vnode 只能属于一个 DB
    vgroups：

Frequently Used:
    Database:
        # 创建数据库
        # 可用参数文档： https://docs.tdengine.com/taos-sql/database/
        #   replica 3       # 配置当前 db 的副本数量是 3， @trap dnode 数量必须大于 replica 的数量，否则报错
        # @trap 最多 4096 列
        taos> create database db1 keep 365 days 10 blocks 6 update 1;

        # 查看建库语句
        taos> show create database db_name;
    
    STable:
        # 创建超级表
        # 支持的数据类型文档： https://docs.tdengine.com/taos-sql/data-type/
        # @trap 第一列的数据类型必须是 timestamp 类型，且唯一
        taos> create stable if not exists stab1 (ts timestamp, current float, voltage int, phase float) tags (location binary(64), groupid int);

        taos> show stables like tb_name_wildcard;   # 查看所有超级表
        taos> show create stable stb_name;          # 查看建表语句
        taos> describe stb_name;                    # 查看表定义
        
    SubTable:
        # 手动创建子表
        # 表文档: https://docs.tdengine.com/taos-sql/table/
        taos> create table stab1_dcpid using stab1 tags ("california.sanfrancisco", 2);
        taos> create table stab1_dcpid using stab1 (tag1, tag2) tags ("california.sanfrancisco", 2);    # 创建子表时，只使用超级表中的一部分 tags，其他 tags 都设置为 null

        # 插入数据时自动创建子表
        # @docs https://docs.tdengine.com/taos-sql/insert/#automatically-create-table-when-inserting
        taos> insert into stab1_dcpid using stab1 tags ("california.sanfrancisco", 2) values (now, 10.2, 219, 0.32);

        taos> show tables like tb_name_wildcard;    # 查看所有表
        taos> show create table tb_name;            # 查看见表语句
        taos> describe tb_name;                     # 查看表定义
        
    Tune:
        # @docs 性能优化： https://docs.tdengine.com/2.6/operation/optimize/
        # @docs 配置参数： https://docs.tdengine.com/2.6/reference/config/
        调整 vgroups 数量，推荐 2 * number_of_cpu_cores
        调整 minTablesPerVnode, tableIncStepPerVnode, maxVgroupsPerDb 使 vnodes 间的负载更均衡
    
    Continuous Query: 
        # 查看所有 连续不断的查询
        taos> show streams;   

        # 关闭一个 连续不断的查询
        taos> kill stream;

        # 连续查询 和 基于时间窗口的流计算 的区别：
        #   流计算 实时执行 并 实时返回结果，而 连续查询 只在指定的时间窗口执行并返回结果
        #   如果插入一条历史数据，但是 连续查询 执行的时间窗口已过，那么这条历史数据不会被重新考虑
        #   如果数据是写回到 client 的，那么 server 不保存 client 的状态 也不保证只返回一次；如果数据协会到 tdengine，那么可以保证有效且是连续的
        # 
        # 语句说明:
        #   每隔 1m 对 stab1 的 voltage 列计算一次平均值，并将结果保存到 stab1_min_avg 表中，
        #   interval(1m, 10s)：指 连续查询 使用指定时间范围内数据 执行查询操作，这个 时间范围 就是 时间窗口，1m: 时间范围的大小，10s: 偏移
        #   sliding: 时间窗口每次向前移动的步长为 30s
        #   {startTime}: 最近时间窗口起始点的时间戳 
        #   now: 代表 连续查询 创建的时间点，而不是 执行 的时间点
        # @trap 最小时间窗口 10 milliseconds
        # 
        taos> create table stab1_min_avg as select avg(voltage) from stab1 where ts>{startTime} interval(1m, 10s) sliding(30s);

    Dnode:
        taos> show dnodes;

    Mnode:   
        # tdengine 配置文件中的 numOfMNodes 可以控制主节点的数量，可用范围为 [1,3]，为保证数据一致性，主节点间数据复制是同步的  
        taos> show mnodes;

    Vgroups:
        taos> use db1;
        taos> show vgroups;
