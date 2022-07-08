/******************************* Architecture ************************/
Instance -(n:1)-> Database -(1:n)-> Tablespace -(1:n)-> Table -(1:n)-> File
                           -(1:n)-> User -(1:1)-> Schema(表示该用户可以使用的数据库对象 table producer function 等的集合，在创建用户的同时创建同名 schema，schema 不能通过其他途径创建) 


/******************************* Glossary and Terminology *******************/
Database: 指存储在硬盘上的数据文件的集合
Instance: 指服务器中用于访问 Database 中数据的集合
Connection：指物理上的客户端同服务器的通信链路，Connection 可以没有 Session，例如连接池
Session：指逻辑上的用户同服务器的通信交互时，服务器端保存的交互 Context（上下文环境），维持 Session 也可以没有 Connection，例如： Token 形式保存，访问服务器时再新建一个 Connection 即可   
Lock: 指用户操作数据库表时，对表或行等进行加锁，防止其他用户同时修改，造成同步问题
Schema: 指 Database 中所有数据文件的部分子集，不能独立创建，随用户的创建而创建，但和用户是 1:1 的关系

/******************************* Oracle Key/Reserved Word Dictionary *******************/
select t.* from v$reserved_words t order by keyword asc;

/******************************* Data Type ***********************************************/
    字符型：
        VARCHAR2(size)      可变长度的字符串, 必须规定长度
        CLOB                超长文本字符串
    
    数字型：
        NUMBER(p,s)         数字型p是位数总长度, s是小数的长度, 可存负数
    
    时间型：
        DATE                精确度 秒
        TIMESTAMP           精确度 纳秒   
    
    文件类型：
        BLOB                二进制文件
        BFILE               外部二进制文件

/******************************* Operator **********************************************/
'qwer'          -- 字符串包含
"qwer"          -- 列名包含
''              -- 转义 表示一个 单引号
*               -- 
%               -- like 语句，表示 任意字符串
_               -- 表示某个字符
?               -- 表示某个字符
#               -- 表示某个数字0-9
[a-d]           -- 表示 a 到 d 之间的字符
||              -- 连接字符串
&               -- 定义变量，如果想当做普通字符使用，输入 SQLPlus 命令 set define off; 注意不是 SQL 命令
&&              -- 定义final变量
/               --表示让服务器执行前面所写的sql脚本。如果是普通的select语句，一个分号，就可以执行了。但是如果是存储过程，那么遇到分号，就不能马上执行了。这个时候，就需要通过斜杠(/)来执行。


/******************************* DBMS Connnect **********************************************/
shell> lsnrctl start                 -- 起动监听
shell> lsnrctl stop                  -- 关闭监听

-- User 登陆、登出
shell> sqlplus /nolog                       -- 登录 sqlplus
SQL> conn username/password@KSF as sysdba;  -- 连接 oracle ：密码文件认证
SQL> conn / as sysdba;                      -- 连接 oracle ：操作系统认证，当当前用户属于 操作系统 dba 用户组时才可以登录


-- Instance 的启动、关闭
SQL> starup [force] [restrict] [pfile=...] [nomount] [mount] [open];    -- 启动 Instance

SQL> shutdowm abort|immediate|transactional|normal;                     -- 关闭 Instance          
        -- shutdown有四个参数，四个参数的含义如下：
        -- normal 需要等待所有的用户断开连接
        -- immediate 等待用户完成当前的语句
        -- transactional 等待用户完成当前的事务
        -- abort 不做任何等待，直接关闭数据库

SQL> quit;                                  -- 退出 sqlplus



/******************************* Frequently Operator ************************/
select * from V$database; -- 查看当前数据库信息，DBA 权限
select * from V$instance; -- 查看当前使用的 Instance 信息
select * from v$session; -- 查看当前所有会话
select * from v$process; -- 查看当前所有进程信息
select * from v$lock; -- 当前数据库拥有的锁以及未完成的锁
select * from v$locked_object; -- 当前 database 中被锁住的 object
select * from v$session_wait; -- 记录 session 在当前数据库中等待什么资源
select * from dba_objects; -- 查看当前数据库中所有对象，包括表、视图、函数、存储过程等


/******************************* Oracle 解锁操作 ************************/
-- 查找锁定的表和进程
select t1.locked_mode,
       t2.sid, t2.serial#, t2.username, t2.schemaname, t2.osuser, 
       t3.object_type, t3.object_name 
from v$locked_object t1 left join v$session t2 on t1.session_id=t2.sid
     left join dba_objects t3 on t1.object_id=t3.object_id;

-- 杀掉进程 sid, serail#
alter system kill session '2849,21686' immediate;

