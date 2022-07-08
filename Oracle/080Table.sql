/************************************************* Table **********************************************/
-- 查表
select * from dba_tables; -- 查询当前数据库所有的表，需要你的账号有 DBA 权限
select * from all_tables where owner='BPM_ISSUE'; -- 查看你可以访问的所有表
select * from user_tables; -- 查询 你 拥有的表
select dbms_metadata.get_ddl('TABLE','tableName'[, 'SCHEMA_NAME']) from dual; -- 查看建表语句

-- 建表
create table tab(
    type_varchar2 varchar2(20),
    type_number number(38,4),   -- 总长度 38 位， 小数 4 位
    type_date date default sysdate,
    birthday timestamp,
    type_clob clob,
    type_blob blob,
    type_bfile bfile,
    constraint oracle_pk primary key(type_varchar2, type_number),
    constraint oracle_uq unique(type_varchar2, type_number),
    constraint oracle_ck check(type_varchar2 is not null, type_number>10),
    constraint oracle_fk foreign key(type_varchar2, type_number)references "otherTable"(str, num)
);

create table new_table as select * from old_table;
                                                 
-- 删表
drop table tab;

-- 改表
alter table tab rename to tab2;

/************************************************* View **********************************************/
select * from dba_views; -- 查看当前数据库中所有的视图，需要你的账号有 DBA 权限
select * from all_views where owner='BPM_ISSUE'; -- 查看你可以访问的所有视图
select * from user_views; -- 查询 你 拥有的视图

-- 创建视图
create or replace force view1 (alias1, alias2, alias3) as  -- force 表示无论基表是否存在都创建视图
select 
from 
[with check option  -- 表示通过视图进行的修改，必须也能通过该视图看到修改后的结果。
    [constraint view1_checkOpiton] -- 指定上面 check option 约束的名称
] 
[with read only] -- 表示该视图时只读视图，不能通过该视图修改基表 

-- 删除视图
drop view view1

-- 修改视图: 直接用 or replace 重建
-- 查询视图：基本上跟普通查询表一样


