/************************************************* User **********************************************/
-- 系统默认账号
sys, system         -- oracle 数据库内部使用的数据字典账号，实际使用的时候一般情况是禁止登陆的


select * from dba_users; -- 查看当前数据库中所有用户，前提是你的账号有 dba 权限，如 sys，system
select * from all_users; -- 查看你能管理的所有用户
select * from user_users; -- 查看你自己的用户信息
select * from dba_sys_privs where grantee='WZSB';           -- 查看指定用户所有的权限
select * from dba_role_privs where grantee='WZSB';          -- 查看指定用户拥有的角色


create user kasei 
identified by kasei  
default tablespace tsKasei
temporary tablespace tsKaseiTmp
quota unlimited on tsKasei; /* 指定配额 */
    
    
-- 删除用户
drop user zl cascade;
    
    
-- 用户修改 
alter user username identified by newpasswd;                --更改用户密码，前提：dba权限
alter user 用户名 account lock;/*锁定用户 */
alter user 用户名 account unlock;/*解锁用户 */
alter user user_name default tablespace tablespace_name;/* 修改用户默认表空间 */
alter user user_name temporary tablespace tablespace_name;/* 修改用户临时表空间 */
alter user suer_name quota (100 m or unlimited) on tablespace_name;/* 修改用户能在该表空间中使用的存储空间配额 */
