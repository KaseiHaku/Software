/******************************* Index ********************************
 * https://dev.mysql.com/doc/refman/8.0/en/create-index.html
 * 索引失效原因:
 *  - 如果是 datetime 类型且可以为 null, 那么即使建了 index 也无效，因为 mysql 的 datetime 类型的字段对 null 值是不进行索引的
 *    解决方案:
 *      + 将 datetime 类型改成 timestamp 类型，因为 timestamp 类型对于空值是进行索引的
 *      + 将 datetime 类型的字段设置成为 not null
 *  
 *  - 联合索引不满足 最左匹配
 *  - 使用 select * 查出没建索引的列
 *  - 索引列上有计算(包括 函数 或 普通算术计算)
 *  - like 左边带 % 
 *  - 两个索引列之间进行判断，例如：where colA > colB
 *  - 使用 or 关键字时，所有列必须都有索引才会走索引，有一个 or 条件列没建索引，会导致所有条件中的索引失效
 *  - 使用否定条件，例如: !=, not in, not exist, not between and 等
 *  - order by 多列时，
 *    多列都在一个 联合索引中时，列声明顺序不符合联合索引 最左匹配
 *    多列都在一个 联合索引中时，每个列的 order by 排序规则不同时，也不会走索引
 *    每个列分别有索引，但是不在联合索引中，不会走每列单独的索引
 *  
 *  
 */


mysql> show indexes in tb_name;
mysql> show keys from table_name;-- 查看某一数据库中某一张表的所有索引

mysql> create index idx_name using btree on tb_name (col1 asc, col2 desc);  -- 创建索引
mysql> drop index idx_name on tb_name;  -- 删除索引



mysql> explain select * from tb;    -- 查看是否走 index
















