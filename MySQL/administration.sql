/******************************* Startup/Shutdown *****************************/
shell> mysqld --verbose --help                                  -- 查看帮助及默认系统变量值
shell> mysqladmin -u root -p shutdown                           -- 使用 mysql 工具停止 mysql 服务


/******************************* Login/Logout *********************************/
shell> mysql -h localhost -u root -p                            -- 使用 localhost 主机下的 root 用户进行密码验证登陆
msyql> quit;                                                    -- Logout


/******************************* User Manager *********************************/

mysql> create user 'kasei'@'%' identified by 'haku';            -- 创建 % （任意）主机下的 kasei 用户，登陆密码为 haku
mysql> drop user 'kasei'@'%';                                   -- 删除 % 主机下的 kasei 用户， 注意：对其他主机下的 kasei 用户并不影响
mysql> set password for 'kasei'@'%' = password('newpassword');  -- 修改指定用户的登陆密码，需要 root 权限
mysql> set password = password("newpassword");                  -- 修改当前用户的登陆密码
mysql> show create user user;

/****************************** Database Manager ******************************/
mysql> show databases;                                          -- 查看当前数据库系统中所有的数据库
mysql> create database mydb;                                    -- 创建一个数据库
mysql> drop database mydb;                                      -- 删除一个数据库
mysql> use mydb;                                                -- 使用 mydb 这个数据库
mysql> show global variables where variable like '%a%';         -- 查询 mysql 所有配置信息
mysql> show variables where variable like '%a%';                -- 查询 mysql 所有配置信息
mysql> show global status;                                      -- 查询 mysql 运行状态
mysql> show character set;                                      -- 查看所有支持的字符集
    

/****************************** Privilege Manager ****************************×
 * @doc https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html#privileges-provided-summary
 */

-- Global Privilege
-- 存储位置 mysql.user 表
mysql> select * from mysql.user where user='test';              -- 查询一个用户的全局权限
mysql> grant all on *.* to 'username'@'%' identified by 'test'; -- 添加一个用户的全局权限，* 表示对该系统下 所有数据.所有表 授权
mysql> revoke select on *.* from 'username'@'%';                -- 撤销一个用户的权限  -- 删除一个用户的全局权限 
mysql> flush privileges;                                        -- 写入权限，使权限生效
mysql> -- 简单粗暴的方法：直接对存储表进行修改即可，都 tm 不用记授权语句

show privileges; -- 查看所有权限

mysql> show grants;
mysql> show grants for 'replicator-replica'@'%';    -- 查看指定 账号 的权限



-- Database Privilege
-- 存储位置 mysql.db mysql.host 表
mysql> grant all on db_name.* to 'username'@'host';             -- 授予数据库级权限
mysql> revoke all on db_name.* from 'username'@'%';             -- 撤回数据库级权限

-- Table Privilege
-- 存储位置 mysql.tables_priv 表
mysql> grant all on MyDB.kkk to test@'%' identified by 'test';  -- 授予表级权限

-- Column Privilege
-- 存储位置 mysql. 表
mysql> grant select (id, col1) on MyDB.TEST1 to test@'%' identified by 'test';  -- 授予列级权限

-- Subprogram Privilege
-- 存储位置 mysql.procs_priv 表
mysql> grant execute on procedure MyDB.PRC_TEST to test@'%' identified by 'test';



/****************************** Information Manager ***************************/
-- DBMS
mysql> show global status;
mysql> show session status;
mysql> show global variables;
mysql> show session variables;
mysql> show replica status;
mysql> show slave hosts; -- 同上
mysql> show storage engines; -- 查看存储引擎
mysql> show warnings;           -- 查看 sql 执行过程中出现的警告
mysql> show errors;
mysql> show [full] processlist; -- 查看当前执行列表


-- Database or Schema
mysql> show databases like ''; -- 查看所有数据库(schema)
mysql> show create database db_name; -- 查看数据库创建语句
mysql> show databases; -- 查看系统中所有数据库
mysql> use information_schema; -- 使用某一个数据库

-- Table
mysql> show create table tbl_name;
mysql> show full columns in tb_name in db_name like '';  -- 查看表列信息
mysql> select table_name from information_schema.tables where table_schema = 'db_name'; -- 查看一个数据库中所有的表
mysql> show tables; -- 查看当前数据库中所有表
mysql> desc tb_name; -- 查看当前数据库中某张表的表结构
mysql> show create table tb_name; -- 查看当前数据库中某一张表的建表 sql 语句

-- Column
mysql> select COLUMN_NAME from information_schema.COLUMNS where table_name = 'tb_name'; -- 查看某张表的所有字段

-- View
mysql> show create view view_name;
mysql> select * from information_schema.view; -- 查看所有视图
mysql> show table status where comment='view';  -- 查看所有视图
mysql> describe v_name; -- 查看某一个视图的结构
mysql> show create view v_name; -- 查看某一个视图的创建语句

-- Constraint and Index
mysql> show indexes in tb_name;
mysql> show keys from table_name;-- 查看某一数据库中某一张表的所有索引
mysql> select * from information_schema.table_constraints; -- 查看某张表的所有约束条件
mysql> select * from key_column_usage; -- 该表保存系统中所有外键的具体信息


-- Procedure
mysql> show create procedure proc_name;
mysql> select name from mysql.proc where db='db_name' and type = 'PROCEDURE'; -- root 权限，查看某个数据库中的所有存储过程

-- Function
mysql> show function code func_name;
mysql> show function status like '';
mysql> show create function func_name;
mysql> select name from mysql.proc where db='db_name' and type = 'FUNCTION';  -- root 权限，查看某个数据库中的所有函数



-- Trigger
mysql> show triggers;
mysql> show create trigger trigger_name;

-- Event: 定时任务
mysql> show events in schema_name like '';
mysql> show create event event_name; 

/******************************* System Variable ******************************/
-- Read
mysql> show variables;          -- 查看所有系统参数    
mysql> show variables where Variable_name='auto_increment_offset'; -- 查看指定的系统参数
mysql> show variables like 'character_set_%';  -- 模糊查询系统参数

-- Update
mysql> set sql_safe_updates = 0;  			-- 设置safe-updates模式 是否开启 
mysql> set foreign_key_checks = 0;          -- 0: 不检查外键约束; 1: 检查外键约束



/******************************* Character Set Manager ************************/
/* 简介：
 * mysql 字符集层级
 * 服务器字符集：Server
 * 数据库字符集：Database
 * 表字符集：Table
 * 列字符集：Column
 * 连接字符集：Connection
 * */
mysql> show character set like '%pattern%';     -- 查看当前支持的所有字符集
mysql> show collation like 'pattern';           -- 查看当前支持的所有排序规则
mysql> show variables like 'collation_%';       -- 查看当前配置的排序规则
mysql> show variables like 'character_set_%';   -- 查看当前配置的字符集



/******************************* binlog ******************************/
mysql> show binary logs;            -- 查看 binlog
mysql> show binlog events;          -- 查看第一个 binlog
mysql> show binlog events in 'binlog.filename';  -- 查看指定文件的 binlog
mysql> set global expire_logs_days=30;      -- 配置 binlog 过期时间为 30 天

-- 手动删除 binlog
mysql> reset master;                                                -- 删除所有binlog日志，新日志编号从头开始
mysql> purge master logs to 'mysql-bin.010';                        -- 删除 mysql-bin.010 之前所有日志
mysql> purge master logs before '2003-04-02 22:46:26';              -- 删除 2003-04-02 22:46:26 之前产生的所有日志
mysql> purge master logs before date_sub( now( ), interval 3 day);  -- 清除 3 天前的 binlog

/******************************* Mater/Slaver & Source/Replica 配置 ******************************/
-- Master or Source
mysql> grant replication client on *.* to 'replicator-replica'@'%';     # 主库给复制账号授权
mysql> flush tables with read lock;                     # 锁表，防止数据写入（同步失败时，或备份时使用）
mysql> unlock tables;                                   # 解锁
mysql> show master status;                              # 查看主库信息


-- Slaver or Replica
-- 在从库中，配置主库连接信息
mysql> change replication source to\
        source_host = 'mysql-master',
        source_port = 3306,
        source_user = 'replicator-replica',
        source_password = '1234',
        source_auto_position = 1;                       # 表示 事务是采用 GTID 标识的
mysql> start replica;                                   # 开启同步
mysql> stop replica;
mysql> show replica status;                             # 查看从库信息
mysql> show master status;                              # 查看主库信息
mysql> set global sql_slave_skip_counter = 1;           # 设置跳过错误步数，数字任意，用于 binlog+position 方式部署的主从模式


