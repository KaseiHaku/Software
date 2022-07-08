/************************************************* Privilege **********************************************/
-- Query
    select * from system_privilege_map order by name;    -- 查询系统中所有可用的权限
                                    
    
    select * from dba_roles;        -- 查看当前数据库下所有角色
                                    -- 查看一个角色拥有的权限
                                    -- 查看拥有该角色的所有用户
-- Add
    grant dba, resource, connect, create table, create view to kasei; -- 给用户授予权限

-- Delete
    revoke dba from 用户名;-- 收回管理员权限*

/************************************************* Role **********************************************/
-- 系统自带角色
sysdba          -- 数据库最高权限， sys 和 system 账号都属于该角色
sysoper         -- 该角色只能操作已经授权的操作
...

-- 创建角色
-- 删除角色
-- 修改角色
-- 查询角色信息



    
