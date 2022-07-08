/** todo 一次性插入多条记录 */
insert into tb(col1, col2)
select val1, val2 from (
    select 6 as val1, 'a' as val2 from dual
    union
    select 1 as val1, 'b' as val2 from dual
);


/** todo 一次性往多表里面插入数据 */
insert all 
into tb1(col1, col2, col3) values(val1, val2, val3)  -- 这里的 val1 是 subquery 的列名
into tb2(col1, col2, col3) values(val1, val2, val3)
select 1 from dual;


insert all
into table_name (列1, 列2,...) values (sequence_test.nextval, 值2,....)
into table_name (列1, 列2,...) values (sequence_test.nextval+1, 值2,....)
into table_name (列1, 列2,...) values (sequence_test.nextval+2, 值2,....)
select * from dual;




-- 存在即更新，不存在即插入
merge into tab1 t1
using (select * from tab2) t2 on (t1.col1 = t2.col1 )
when matched then 
	update set t1.col2=v2, t1.col3=v3 where t2.col2>100
  delete where t2.col2<100
when not matched then 
	insert(t1.col1, t1.col2, t1.col3) 
  values(t2.col1, t2.col2, t2.col3) 
  where t2.col2=100 
;
