/******************************* Startup/Shutdown *****************************/
shell> mysqld --console                                         -- 命令行启动 mysql
shell> net start mysql                                          -- 命令行启动 windows 服务 mysql
shell> net stop mysql                                           -- 命令行关闭 windows 服务 mysql
shell> mysqladmin -u root -p shutdown                           -- 使用 mysql 工具停止 mysql 服务


/******************************* Login/Logout *********************************/
shell> mysql -h localhost -u root -p                            -- 使用 localhost 主机下的 root 用户进行密码验证登陆
msyql> quit;                                                    -- Logout


/******************************* User Manager *********************************/

mysql> create user 'kasei'@'%' identified by 'haku';            -- 创建 % （任意）主机下的 kasei 用户，登陆密码为 haku
mysql> drop user 'kasei'@'%';                                   -- 删除 % 主机下的 kasei 用户， 注意：对其他主机下的 kasei 用户并不影响
mysql> set password for 'kasei'@'%' = password('newpassword');  -- 修改指定用户的登陆密码，需要 root 权限
mysql> set password = password("newpassword");                  -- 修改当前用户的登陆密码


/****************************** Database Manager ******************************/
mysql> show databases;                                          -- 查看当前数据库系统中所有的数据库
mysql> create database mydb;                                    -- 创建一个数据库
mysql> drop database mydb;                                      -- 删除一个数据库
mysql> use mydb;                                                -- 使用 mydb 这个数据库
mysql> show global variables where variable like '%a%';         -- 查询 mysql 所有配置信息
mysql> show variables where variable like '%a%';                -- 查询 mysql 所有配置信息
mysql> show global status;                                      -- 查询 mysql 运行状态
mysql> show character set;                                      -- 查看所有支持的字符集
    

/****************************** Privilege Manager *****************************/
-- Global Privilege
-- 存储位置 mysql.user 表
mysql> select * from mysql.user where user='test';              -- 查询一个用户的全局权限
mysql> grant all on *.* to 'username'@'%' identified by 'test'; -- 添加一个用户的全局权限，* 表示对该系统下 所有数据.所有表 授权
mysql> revoke select on *.* from 'username'@'%';                -- 撤销一个用户的权限  -- 删除一个用户的全局权限 
mysql> flush privileges;                                        -- 写入权限，使权限生效
mysql> -- 简单粗暴的方法：直接对存储表进行修改即可，都 tm 不用记授权语句

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
-- 数据库
mysql> show databases; -- 查看系统中所有数据库
mysql> use information_schema; -- 使用某一个数据库

-- 表
mysql> select table_name from information_schema.tables where table_schema = 'db_name'; -- 查看一个数据库中所有的表
mysql> show tables; -- 查看当前数据库中所有表
mysql> desc tb_name; -- 查看当前数据库中某张表的表结构
mysql> show create table tb_name; -- 查看当前数据库中某一张表的建表 sql 语句

-- 列
mysql> select COLUMN_NAME from information_schema.COLUMNS where table_name = 'tb_name'; -- 查看某张表的所有字段

-- 视图
mysql> select * from information_schema.view; -- 查看所有视图
mysql> show table status where comment='view';  -- 查看所有视图
mysql> describe v_name; -- 查看某一个视图的结构
mysql> show create view v_name; -- 查看某一个视图的创建语句

-- 约束条件
mysql> select * from information_schema.table_constraints; -- 查看某张表的所有约束条件
mysql> select * from key_column_usage; -- 该表保存系统中所有外键的具体信息

-- 索引
mysql> show keys from table_name;-- 查看某一数据库中某一张表的所有索引

-- 存储过程
mysql> select name from mysql.proc where db='db_name' and type = 'PROCEDURE'; -- root 权限，查看某个数据库中的所有存储过程

-- 存储函数
mysql> select name from mysql.proc where db='db_name' and type = 'FUNCTION';  -- root 权限，查看某个数据库中的所有函数

-- 执行警告
mysql> show warnings;           -- 查看 sql 执行过程中出现的警告


/******************************* Character Set Manager ************************/
/* 简介：
 * mysql 字符集层级
 * 服务器字符集：Server
 * 数据库字符集：Database
 * 表字符集：Table
 * 列字符集：Column
 * 连接字符集：Connection
 * */
mysql> show variables like 'collation_%';    
mysql> show variables like 'character_set_%';

/******************************* System Variable ******************************/
-- Read
mysql> show variables;          -- 查看所有系统参数    
mysql> show variables where Variable_name='auto_increment_offset'; -- 查看指定的系统参数
mysql> show variables like 'character_set_%';  -- 模糊查询系统参数

-- Update
mysql> set sql_safe_updates = 0;  			-- 设置safe-updates模式 是否开启 
mysql> set foreign_key_checks = 0;          -- 0: 不检查外键约束; 1: 检查外键约束




