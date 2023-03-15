/******************************* Index ********************************
 * https://dev.mysql.com/doc/refman/8.0/en/create-index.html
 * 索引失效原因:
 *  - 如果是 datetime 类型且可以为 null, 那么即使建了 index 也无效，因为 mysql 的 datetime 类型的字段对 null 值是不进行索引的
 *    解决方案:
 *      + 将 datetime 类型改成 timestamp 类型，因为 timestamp 类型对于空值是进行索引的
 *      + 将 datetime 类型的字段设置成为 not null
 */


mysql> show indexes in tb_name;
mysql> show keys from table_name;-- 查看某一数据库中某一张表的所有索引

mysql> create index idx_name using btree on tb_name (col1 asc, col2 desc);  -- 创建索引
mysql> drop index idx_name on tb_name;  -- 删除索引



mysql> explain select * from tb;    -- 查看是否走 index
















