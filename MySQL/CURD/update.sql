/* 适用于 更新值 相同的更新 */
update t
set 
    intCol=123, 
    varcharCol='fwef', 
    nullCol = null,
    jsonCol='{}', 
    jsonCol2=json_set(jsonCol2, '$.key', 'value')
where ;

/* 适用于 更新值 随条件变化的更新 */
update t 
    set 
    col1 = 
    case id 
        when 1 then 3 
        when 2 then 4 
        when 3 then 5 
    end, 
    title = 
    case id 
        when 1 then 'new title 1' -- else 'new title 1-1'
        when 2 then 'new title 2'
        when 3 then 'new title 3'
    end
where id in (1,2,3); -- 没有作用，只是确保只有3行数据执行

/* with */
with aa as()
update ...

/* 骚操作: 创建临时表 */
create temporary table tmp(id int(4) primary key, dr varchar(50));
insert into tmp values  (0,'gone'), (1,'xx'),...(m,'yy');
update test_tbl left join tmp on col1=col2 and col3=col4
set test_tbl.dr=tmp.dr where test_tbl.id=tmp.id;
