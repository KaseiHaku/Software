/* 删除行 */
delete t1, t2 from tab1 t1 inner join tab2 t2
where ;

delete from t1, t2 using tab1 t1 inner join tab2 t2
where ;


-- 单表模式，oracle 只支持这种格式
delete from tb
where ;

/* with */
with aa as()
delete ...

/* 清空表数据 */
truncate table tb; 
