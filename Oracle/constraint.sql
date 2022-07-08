/************************************************* Constraint **********************************************/
-- Query
    -- 查询当前数据库中所有约束条件
    -- 查询指定约束条件的具体信息
    select * from USER_CONSTRAINTS;                         --查看 DB 中所有表级约束条件
    select * from UESR_CONS_COLUMNS;                        --查看 DB 中所有列级约束条件

-- 添加约束条件：
alter table oracle add constraint oracle_uq2 unique(type_clob);

-- 删除约束条件：
alter table oracle drop constraint oracle_uq2;

-- 修改约束条件名：
alter table oracle rename constraint oracle_uq2 to oracle_uq3;

-- 启用|禁用约束条件：
alter table oracle <enable|disable> constraint oracle_uq3 [cascade|restrict]-- cascade：不管该数据库下有没有表都执行该语句 restrict：数据库下有表不执行该语句

-- 修改空或非空：
alter table oracle modify type_clob not null;

-- 修改默认值：
alter table oracle modify type_number default null; -- default null:表示没有默认值
