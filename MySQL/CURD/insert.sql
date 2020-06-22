/* 直接插入 */
insert into tb1(col1, col2, col3)
values
    (123, 'hello', 'word'), 
    (456, 'hggf', 'wfew')
;

/* 从单表中取数据并插入 */
insert into tb1 (field1,field2) 
select field1,field2 
from tb2;


/* 从多表中取数据并插入 */
insert into tb1 (field1,field2)  
select * 
from(
	select t2.f1, t3.f2 
  from tb2 t2 join tb3 t3 on t2.col=t3.col and t2.col2=2
) as t2;
