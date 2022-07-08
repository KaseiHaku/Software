/* MySQL 数据类型：
	charactor: varchar(65535)  --> java.lang.String
	
	number: int(11)   --> java.lang.Integer     括号里的 11 表示的是显示长度，跟存储没啥关系
	        bigint(20)  --> java.lang.Long, java.math.BigInteger
			decimal(m,d) 参数m<65 是总位数，d<30且 d<m 是小数位。 --> java.math.BigDecimal
			
	date: 	datetime  日期时间 '2008-12-2 22:06:44'  --> java.sql.Timestamp
	查 增 删 改
	
    Mysql 中的转义字符	
    \0	An ASCII NUL (X'00') character
    \b	A backspace character
    \n	A newline (linefeed) character
    \r	A carriage return character
    \t	A tab character.
    \Z	ASCII 26 (Control+Z)
    \N	NULL
 */

--------------------------------------------- Query Add Delete Modify ------------------------------------------------



mysql> set sql_safe_updates = 0;  			-- 设置safe-updates模式 是否开启
mysql> source e:/tty.sql;					-- 在一个数据库下执行一个 .sql 文件
mysql> show global variables;               -- 查看数据库系统所有的全局参数

/* 对 mydb 这个数据进行备份，mydb.dbb 就是备份文件 */
C:\WINDOWS\system32> mysqldump --opt mydb>mydb.dbb 
/* 用批处理方式使用MySQL */
C:\WINDOWS\system32> mysql < mytest.sql > mytest.out  -- 对 mytest.sql 进行批处理，处理结果重定向到 mytest.out 文件中



/* 表相关 */
mysql> select table_name from information_schema.tables where table_schema = '数据库名'; -- 查看一个数据库中所有的表
mysql> show tables; -- 查看当前数据库中所有的表
mysql> desc tablename; -- 查看一个表的表结构



-- 创建表
create table t(
	col1 int(9) auto_increment,
	col2 bigint(9) default 888,
	col3 varchar(65535) not null,
	col4 date,
	col5 datetime,
	col6 timestamp comment '列的注释',
	constraint t_pk primary key(col1, col2),  -- 联合主键
	constraint t_fk foreign key(col4) references t2(id),
	constraint t_uk unique key(col4, col5),  -- 联合唯一索引
    index indexName col3(65535)
)AUTO_INCREMENT=1 comment='表的注释'; -- 编码方式：默认的是utf8，  自增长量：可以在这里初始化

-- 删除表
drop table t;

-- 修改表名
alter table t
rename t2;

-- 修改表注释
alter table t comment '修改后的注释';


alter table t auto_increment=1000;  -- 修改主键自增


/* Constraint */
-- 添加约束条件

alter table t add constraint t_pk2 primary key(col2);
alter table t add constraint t_fk2 foreign key(col4) references t2(id);
alter table t alter column col1 set default 888;
alter table t add unique key t_uk2 (col1, col2);
alter table t modify col1 int(9) not null;

-- 删除约束条件
alter table t drop primary key t_pk;
alter table t drop foreign key t_fk;
alter table t alter column col1 drop default; -- 删除 default 约束
alter table t drop index t_uk;  -- 删除 unique 约束
alter table t modify col1 int(9) null; -- 删除 not null 约束


/* Column */
mysql> select column_name from information_schema.columns  where table_name='***';  -- 查看数据库中所有表的列

-- 添加列
alter table t add column col varchar(20) not null default '' comment '';

-- 删除列
alter table t drop column col;

-- 修改列名
alter table t change col col2 varchar(20) not null default '' comment 'modify column';
alter table t change `id` `id` int(11) not null auto_increment;

-- 修改列的数据类型
alter table t
modify column col varchar(20) not null comment '';


/* Index */
show index from tableName;
create unique index indexName using btree on tableName(colName(16) asc, col2(32) desc);
drop index indexName on tableName;












