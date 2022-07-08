/* 直接插入 */
insert into tb1(intCol, varcharCol, jsonCol)
values
    (123, 'hello', '{ "k1": "v1" }'), 
    (456, 'hggff', '[1, "2", true]')
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

/* 存在则更新，不存在则插入 
 * 语句含义：如果该记录不存在则，插入该条记录，如果存在，则更新 f_market='sh', f_name='浦发银行'
 * 规则：f_market, f_stockid, f_name 这三列中，必须有一列是 unique 索引的，根据 unique 列判断是否重复
 */
insert into t_stock_chg(f_market, f_stockid, f_name) 
values('sh', '600000', '白云机场'),('tz', '12324', '台州路桥机场')
on duplicate key update f_market=values(f_market), f_name=values(f_name);  -- values()  引用 values 中指定字段的值

