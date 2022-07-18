/******************************* Backup ********************************
 * 备份方式:
 *  冷备份(脱机备份): 是在关闭数据库的时候进行的;
 *  热备份(联机备份): 数据库处于运行状态, 依赖于数据库的日志文件; 
 *  温备份: 数据库锁定表格(不可写但可读)的状态下进行备份操作
 *
 * 逻辑备份:
 *  对数据库逻辑组件(如:表等数据库对象)的备份
 *
 * 备份策略:
 *  完全备份: 每次对数据库进行完整的备份; 安全性高, 回滚操作简单, 备份时间长, 数据冗余
 *  差异备份: 备份那些自从上次完全备份之后被修改的文件
 *  增量备份: 只有那些在上次完全备份或者增量备份后被修改的文件才会被备份; 安全性低, 回滚麻烦
 * */


/* 冷备份 + 完全备份 */
shell> 关闭 MySQL 数据库
shell> tar -zcf /home/kasei/mysql/backup/mysql_all_$(date+%F).tar /usr/local/mysql/data

/* 热备份 + 完全备份 */
shell> mysqldump 

/* 增量备份 
 *  MySQL 没有提供直接增量备份的方法, 增量备份以定时保存 MySQL 二进制日志的形式实现
 */

/******************************* Rollback ********************************
 * 误删预防:
 *  1. sql_safe_updates 参数设置为 on, 这样 delete 和 update 没有 where 条件时，语句会报错
 * 
 * delete 误删恢复:
 *  可以使用 Flashback(闪回) 功能进行恢复，但是对  truncate /drop table 和 drop database 无效
 *  需要确保 binlog_format=row 和 binlog_row_image=FULL 
 * 
 * truncate /drop table 和 drop database 误删恢复:
 *  1. 取最近一次全量备份，假设这个库是一天一备，上次备份是当天 0 点；
 *  2. 用备份恢复出一个临时库；
 *  3. 从日志备份里面，取出凌晨 0 点之后的日志；
 *  4. 把这些日志，除了误删除数据的语句外，全部应用到临时库
 *  注意点: 
 *      mysqlbinlog 有一个–database 参数，用来指定误删表所在的库，这样可以跳过其他库，加快恢复速度
 *      需要跳过误操作的语句, 
 *          未使用 GTID 模式: 手动使用 –start-position –stop-position 跳过误删的操作
 *          使用了 GTID 模式: 假设误操作命令的 GTID 是 gtid1，那么只需要执行 set gtid_next=gtid1;begin;commit; 就可以跳过误删的操作
 *
 * */
 
/* 冷备份 + 完全备份 回滚 */
shell> 关闭 MySQL 数据库
shell> mv /usr/local/mysql/data /home/kasei/mysql/restore
shell> tar -zxf /mysql_all_$(date+%F).tar
shell> mv 解压出来的 data /usr/local/mysql
shell> 直接替换现有 MySQL 目录即可
shell> 重启 MySQL

/* 热备份 + 完全备份 回滚 */
mysql> source  

/* 增量备份 回滚 */
mysql> show variables like 'datadir';  -- 查看 mysql 数据目录的位置
mysql> show variables like 'log_%';       -- log_bin=ON 表示开启了 binlog，
mysql> show global variables like '%binlog_form%';      -- 检查binlog的格式: SQL(Statement) 或 ROW，推荐使用 ROW 格式
                                                        -- SQL(Statement): 基于 sql 的,就是会记录执行过的每条sql语句
                                                        -- ROW: 基于 row 行数据的，这种格式的log非常详细，会记录每一行数据修改前和修改后的记录，适合对误操作进行恢复
mysql> show binary logs;    -- 来查看 binlog 文件列表
mysql> show master status； -- 查看当前正在写入的binlog文件
mysql> show binlog events;   -- 只查看第一个binlog文件的内容
mysql> show binlog events in 'binlog.001122';    -- 查看指定binlog文件的内容


-- binlog 是二进制文件，需要用 mysqlbinlog 命令导出为文本文件查看
shell> mysqlbinlog --base64-output=decode-rows                      # never, decode-rows, auto
                   --start-datetime='2021-11-19 14:12:00'           # 执行开始时间
                   --stop-datetime='2021-11-19 14:28:00'            # 执行结束时间
                   --database='bladex'                              # 只显示指定数据库的数据
                   --set-charset=utf8mb4                            # 设置字符集
                   -vv                                              # 当 binlog_form=ROW 时，需要加这个来重构 SQL，不然乱码
                   binlog.001122                                    # 指定 binlog 文件
                   -r /home/binlog.001122.sql                       # 指定导出到哪个文件，如果 --raw 存在，那么这个就是文件前缀

-- 恢复数据
shell> mysqlbinlog --start-position=1232 --stop-position=222 binlog.001122 -r /home/binlog.001122.sql


/******************************* Mysql 数据导入 *******************************/  
-- 导入方式一：load data local infile 命令
mysql> load data 
    [low_priority | concurrent] 
    [local]  -- local 表示是否把文件传到服务器再执行导入，如果没有该关键字，那么导入的文件必须有可读权限, 一般都要该参数
infile 'e:/input.csv'
    [replace | ignore] -- ignore 表示是否在导入的时候忽略外键关系
into table tbl_name
    
    [partition (partition_name [, partition_name] ...)]
    [character set utf8]
    
fields
    terminated by '\t'                   -- 表示每一个字段以 '\t' 分隔
    [optionally] enclosed by '"'     -- 表示所有字段用 '"' 双引号包括着，optionally 表示只有 String 类型的被双引号包含着   
    escaped by '\\'                 -- 表示设置转义字符为 \ 反斜杠
lines
    starting by 'qwer'      -- 表示行开始字符为 'qwer' 导入时忽略
    terminated by '\n'      -- 表示行结尾字符为 \n

    [ignore number {lines | rows}]
    [(col_name_or_user_var[, col_name_or_user_var] ...)]  -- 指定导入到那几列
[
set -- 设置列不是从文件中导入的
    col_name={expr | default}
    [, col_name={expr | default}] ...
]

-- Entire Example
mysql> 
load data local                 -- local 表示吧文件传入服务器再执行导入
infile 'e:/aa.csv' ignore       -- ignore 表示忽略外键关系，一般不使用这个参数，以保证数据完整性
into table tb_user  character set utf8 -- 设置导入的表和字符集
fields terminated by '\t' optionally cnclosed by '"' escaped by '\\' 
lines starting by 'qwer' terminated by '\r\n' ignore 1 lines      -- 忽略第一行
(username, password, @var1)     -- 设置文件中列对应的数据库列，如果设置为 @var1 但是不使用，那么会丢弃该列
set nickname='默认昵称', age=@var1+10       -- 设置不是从文件中直接导入的列的值
partition (parition_name1, partition_name2)  -- 不知道干啥用的，不用


-- Instance
load data local 
infile 'e:/1.csv' 
into table rebuild_1st 
fields terminated by '\t' escaped by '\\' 
lines terminated by '\n' (code, name, degree_code, degree_name, @var);


-- Excel 导入数据库步骤
-- 1. 在 excel 中选取需要导入的数据块，注意一定要要多选出一列，copy
-- 2. 新建一个 excel 文件， 将选出的数据块 paste 到这个文件中
-- 3. 将新建的文件 “另存为” -> “文本文件(制表符分割)(*.txt)”
-- 4. 将另存为的 txt 文件的编码格式改为 utf-8 坑：一定要 UTF-8 NO BOM 格式的
-- 5. 查看文本文件的换行符是哪种；'\r\n' '\n' '\r' 三种；查找 \r 如果有，那么结尾字符应该用 '\r\n'
-- 5. net start mysql （字符界面导入）
-- 6. mysql -u root -p
-- 7. use 需要导入的数据库
-- 8. load data local infile 'e:/tt2.txt' into table tableName fields terminated by '\t';

/******************************* Mysql 数据导出 *******************************/
-- 1. net start mysql
-- 2. use dbname
-- 3. 命令格式
mysql> select * 
into outfile 'e:/output.csv' 
fields 
    terminated by '\t'										-- 设置以 tab 键作为字段分隔标志	
    [optionally] enclosed by '"'							-- 设置字段被 " 包含，如果使用了 optionally 则只有字符串被 " 包含
    escaped by '\\' 										-- 设置 \ 为转义符号
lines 
    terminated by '\n'										-- 每条记录以 \n 结尾
from table_name 
where xingbie="男" 
	
-- 4 修改编码格式为 936 (ANSI/OEM - 简体中文 GBK)
-- 5 打开 excel ，选择 "数据" -> "导入外部数据" -> "选中 D:/man.txt" -> 其中分隔符 选 \t  格式选 纯文本 不要选常规



/******************************* Mysql output .sql ****************************/
shell> mysqldump -u root -p --add-drop-table db_name tb_name1 tb_name2 > e:/dump.sql   # not logged in

/******************************* Mysql execute .sql ***************************/
shell> mysql -u root -p db1 < dump.sql         # not logged in, enclose this command with double quotes in window

shell> mysql -u root -p 

mysql> use db_name;
mysql> source dump.sql;


