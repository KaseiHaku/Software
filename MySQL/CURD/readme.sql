/******************************* explain *******************************/
select 
    -- 当 id 相同时，执行顺序 由上向下;当 id 不同时，id 值越大，优先级越高，越先执行。
    id,
    
    -- 查询的类型
    -- SIMPLE：简单查询，不包含 UNION 或者子查询。
    -- PRIMARY：查询中如果包含子查询或其他部分，外层的 SELECT 将被标记为 PRIMARY。
    -- SUBQUERY：子查询中的第一个 SELECT。
    -- UNION：在 UNION 语句中，UNION 之后出现的 SELECT。
    -- DERIVED：在 FROM 中出现的子查询将被标记为 DERIVED。
    -- UNION RESULT：UNION 查询的结果。
    select_type,
    
    -- 表示查询用到的表名，表别名等
    table, 
    
    -- 匹配的分区，对于未分区的表，值为 NULL
    partitions,
    
    -- 查询执行的类型，描述了查询是如何执行的。所有值的顺序从最优到最差排序为：
    -- system > const > eq_ref > ref > fulltext > ref_or_null > index_merge > unique_subquery > index_subquery > range > index > ALL
    -- system：如果表使用的引擎对于表行数统计是精确的(如：MyISAM)，且表中只有一行记录的情况下，访问方法是 system ，是 const 的一种特例。
    -- const：表中最多只有一行匹配的记录，一次查询就可以找到，常用于使用主键或唯一索引的所有字段作为查询条件。
    -- eq_ref：当连表查询时，前一张表的行在当前这张表中只有一行与之对应。是除了 system 与 const 之外最好的 join 方式，常用于使用主键或唯一索引的所有字段作为连表条件。
    -- ref：使用普通索引作为查询条件，查询结果可能找到多个符合条件的行。
    -- index_merge：当查询条件使用了多个索引时，表示开启了 Index Merge 优化，此时执行计划中的 key 列列出了使用到的索引。
    -- range：对索引列进行范围查询，执行计划中的 key 列表示哪个索引被使用了。
    -- index：查询遍历了整棵索引树，与 ALL 类似，只不过扫描的是索引，而索引一般在内存中，速度更快。
    -- ALL：全表扫描。
    type,
    
    -- possible_keys 列表示 MySQL 执行查询时可能用到的索引。如果这一列为 NULL ，则表示没有可能用到的索引;
    -- 这种情况下，需要检查 WHERE 语句中所使用的的列，看是否可以通过给这些列中某个或多个添加索引的方法来提高查询性能。
    possible_keys,
    
    -- key 列表示 MySQL 实际使用到的索引。如果为 NULL，则表示未用到索引
    key,
    
    -- key_len 列表示 MySQL 实际使用的索引的最大长度;当使用到联合索引时，有可能是多个列的长度和。在满足需求的前提下越短越好
    key_len,
    
    -- 当使用索引等值查询时，与索引作比较的列或常量
    ref,
    
    -- rows 列表示根据表统计信息及选用情况，大致估算出找到所需的记录或所需读取的行数，数值越小越好
    rows,
    
    -- 按表条件过滤后，留存的记录数的百分比
    filtered,
    
    -- 这列包含了 MySQL 解析查询的额外信息，通过这些信息，可以更准确的理解 MySQL 到底是如何执行查询的。常见的值如下：
    -- Using filesort：在排序时使用了外部的索引排序，没有用到表内索引进行排序。
    -- Using temporary：MySQL 需要创建临时表来存储查询的结果，常见于 ORDER BY 和 GROUP BY。
    -- Using index：表明查询使用了覆盖索引，不用回表，查询效率非常高。
    -- Using index condition：表示查询优化器选择使用了索引条件下推这个特性。
    -- Using where：表明查询使用了 WHERE 子句进行条件过滤。一般在没有使用到索引的时候会出现。
    -- Using join buffer (Block Nested Loop)：连表查询的方式，表示当被驱动表的没有使用索引的时候，MySQL 会先将驱动表读出来放到 join buffer 中，再遍历被驱动表与驱动表进行查询。
    -- 当 Extra 列包含 Using filesort 或 Using temporary 时，MySQL 的性能可能会存在问题，需要尽可能避免。
    extra
from explain;





/** insert or update */
-- a, b, c 三列中至少有一列具有唯一索引，如果多个 unique index 那么以 or 来组合 两个索引列，最好保证 a, b, c 中只有一个 unique index
-- ignore 存在时，碰到 duplicate key，那么忽略
insert [ignore] into tab1(a, b, c) values(1, 2, 3) on duplicate key update c=c+1;   

/** insert or replace */
replace into tab1(a, b, c) values(1, 2, 3);   -- a, b, c 三列中至少有一列具有唯一索引，如果碰到当前插入的唯一索引列已经存在，则先 delete 再 insert

/** select into: 将查询结果输出到其他地方，例如：文件 */
select * from tab1 into ;


/** with: 临时表, 递归查询 */
with
    aa as (select * from tab1),
    bb as (select * from tab2),
select * from aa;

/** update multi table: 更新多张表 */
update tab1 t1 left join tab2 t2 on t1.col1=t2.col2 and t1.col3=t2.col4
set t1.dr=t2.dr 
where t1.id=t2.id;




