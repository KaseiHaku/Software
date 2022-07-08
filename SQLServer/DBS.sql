select * from master.dbo.sysconfigures;  -- 查看 DBS(Database System) 配置

/** Connection Process Session 之间的关系
 * C - 1:n -> P
 * P - 1:n -> S
 * */
select t.* from sys.dm_exec_connections t;  -- 查看 DBS 所有连接
select t.* from master.dbo.sysprocesses t; -- 查看 DBS 当前有多少个进程
select t.* from sys.dm_exec_sessions t; -- 查看 DBS 所有会话



select t.* from master.dbo.sysdatabases t; -- 查看 DBS 有多少个数据库




select t.* from master.dbo.sysobjects t;	-- 查看 DBS 中有多少实例（表、视图、存储过程、函数）


select t.* from master.dbo.syscolumns t;  -- 查看 DBS 中所有列

select * from sys.dm_tran_locks;  -- resource_ 开头的列名是资源信息， request_ 开头的列名是锁本身的信息
