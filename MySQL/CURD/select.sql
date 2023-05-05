
/* MySQL 表连接类型 */
from tb1, tb2 on                -- 等价于 inner join
from tb1 full join tb2 on       -- 不支持，使用 left join union right join 替代
from tb1 left join tb2 on 
from tb1 right join tb2 on 
from tb1 inner join tb2 on 


/* 查询
 * @doc https://dev.mysql.com/doc/refman/8.0/en/select.html
 * */
select distinct 
    col1, col2
from tab1 partition( p1, p2, p3sp1)   -- p3sp1   p3 分区中的 sp1 子分区
where 
group by col1, col2 with rollup
having 
window winName as (...)
order by convert(chinese using gbk) asc with rollup -- mysql 中文排序需要使用 gbk 编码才是对的，否则会乱序
limit 100, 10; -- 从 100 行开始读取，一共读取 10 行
limit 10 offset 100; -- 从 100 行开始读取，一共读取 10 行
for update
;







-- 强制走索引 https://dev.mysql.com/doc/refman/8.0/en/join.html
select t.* from tb t force index(idx_name1, idx_name2) where ...;

/* Advance Sql Operating */
-- left join 右表具有多个值 只取一个值的操作
select * 
from b as t3 left join (
  select max(id) as id 
  from b as t1 
  group by t1.b
  ) as t2 on t2.id=t3.id 
where t2.id is not null;


-- group by 后，获取没有 group by 的列
select A.col0
from t1 as A 
  inner join (
    select col1, col2
    from t1
    group by col1, col2) as B
  on (A.col1=B.col1 and A.col2=B.col2);

-- 从一张表中选择数据插入到另一张表中，如果插入数据要对应，那么通过表连接生成新的表即可
insert into target_table(col1, col2, col3)
select col4, col5, col6
from source_table
where ;

-- 删除符合子查询条件的行
  -- 方案一：最佳
  create table temp (col1 int(9)); -- 先建立中间表

  insert into temp
  select 
  from t1
  where;


  delete from t1 as A
  where A.id in (
    select col1
    from temp
    where 
  );

  -- 方案二 次佳
  DELETE e.*
  FROM tableE e
  WHERE id IN (
    SELECT id
    FROM (SELECT id
      FROM tableE
      WHERE arg = 1 AND foo = 'bar') as x);
  -- 方案三                   
  DELETE th
  FROM term_hierarchy AS th
  WHERE th.parent = 1015 AND th.tid IN (
    SELECT DISTINCT(th1.tid)
    FROM term_hierarchy AS th1
    INNER JOIN term_hierarchy AS th2 ON (th1.tid = th2.tid AND th2.parent != 1015)
    WHERE th1.parent = 1015
  );

  -- 方案四
  DELETE FROM `secure_links` WHERE `secure_links`.`link_id` IN 
          (
          SELECT
              `sl1`.`link_id` 
          FROM 
              (
              SELECT 

                  `sl2`.`link_id` 

              FROM 
                  `secure_links` AS `sl2` 
                  LEFT JOIN `conditions` ON `conditions`.`job` = `sl2`.`job` 

              WHERE 

                  `sl2`.`action` = 'something' AND 
                  `conditions`.`ref` IS NULL 
              ) AS `sl1`
          )


-- 查找表中重复的字段，多列
select * from vitae a   
where (a.peopleId,a.seq) in (select peopleId,seq from vitae group by peopleId,seq having count(*) > 1) 

-- 删除表中多余的重复记录，多列
delete from vitae a   
where (a.peopleId, a.seq) in (
        select peopleId, seq 
        from vitae 
        group by peopleId,seq having count(*) > 1                 
        )   
    and rowid not in (
        select min(rowid) 
        from vitae 
        group by peopleId,seq having count(*)>1
    );


/*############################################### Row and Column Convert : Begin ####################################################*/
-- 合并 多列 到 一列, MySQL 8 以上支持 with as 语法: select version();
with aa as ()
select * from aa;
                                
-- 列转行: 把同一行的 三列数据, 变成三行数据
with 
  aa as (
      select '小明' name, '男' gender, '44' chinese, '54' math, '64' english from dual union 
      select '小红' name, '女' gender, '66' chinese, '76' math, '86' english from dual union
      select '小皮' name, '男' gender, '78' chinese, '88' math, '98' english from dual
  )
select nam, gender, '语文' subject, chinese score into templateTable from aa
union
select nam, gender, '数学' subject, math score into templateTable from aa
union
select nam, gender, '英语' subject, english score into templateTable from aa
;


-- 行转列: 指定一列, 把该列中相同值的行归为一类, 再指定另一列, 将该列中不同的值, 变成表中的一列 
-- 方法1 
with 
  aa as (
    select '小明' name, '男' gender, 'chinese' subject, '34' score from dual union
    select '小明' name, '男' gender, 'math' subject, '34' score from dual union
    select '小明' name, '男' gender, 'english' subject, '34' score from dual union
    select '小红' name, '女' gender, 'chinese' subject, '34' score from dual union
    select '小皮' name, '男' gender, 'chinese' subject, '34' score from dual 
  )
select 
  name,
  gender,
  sum(if(subject='chinese', score, 0)) as '语文',
  sum(if(subject='math', score, 0)) as '数学',
  sum(if(subject='english', score, 0)) as '英语'
from aa
group by name, gender;


-- 方法2，推荐
with 
  aa as (
    select '小明' name, '男' gender, 'chinese' subject, '34' score from dual union
    select '小明' name, '男' gender, 'math' subject, '34' score from dual union
    select '小明' name, '男' gender, 'english' subject, '34' score from dual union
    select '小红' name, '女' gender, 'chinese' subject, '34' score from dual union
    select '小皮' name, '男' gender, 'chinese' subject, '34' score from dual 
  )
select
    name,
    gender,
    max(case subject when 'chinese' then score else 0 end) as '语文',
    max(case subject when 'math' then score else 0 end) as '数学',
    max(case subject when 'english' then score else 0 end) as '英语'
from aa
group by name, gender;
         
-- 按指定分隔符拆分一列为多列
select 
   substring_index(substring_index(t1.a, ',', help_topic_id+1), ',', -1) as Id
from (
   select '82,83,84,85,86' as a from dual
) t1 left join mysql.help_topic t2 on t2.help_topic_id < (length(t1.a) - length(replace(t1.a, ',', '')) + 1) or t2.help_topic_id = 0;

/*############################################### Row and Column Convert : End ####################################################*/

/* mysql 函数
    使用函数的时候要先清楚一件事，
    select name, colvar from tab; 
    其中的 name 和 colvar 是列值变量，可以存取列值的.
    在不同的上下文中有不同的含义，如：
    在 max(name);  count(name); sum(name); 等函数中，name 相当于 Java 中的 List<name> name 变量；
    在 if(name='Kasei', 1, 0);  case name when 'Kasei' then 1 else 0 end; 中 name 相当于Java 中 String name; 即直接表示列值
*/
if(exp1, exp2, exp3)  -- 如果 exp1 等于 ture，则返回 exp2，否则返回 exp3

select id, group_concat([distinct] name [order by asc/desc 排序字段] [separator ',']) from aa group by id;

/* partition */
partition(partition_name1, partition_name2, partition_name3)

/* 开窗函数 
    https://dev.mysql.com/doc/refman/8.0/en/window-functions.html
*/
select max(t.a) over() from tb t;



/* 常用 sql */
select     
    max(case roh when 1 then COLUMN_NAME else 0 end) as z1
from 
(select @rowno:=@rowno+1 roh, COLUMN_NAME from information_schema.COLUMNS, (select @rowno:=0) t2 where table_name = 'discipline_school') t3;
                                                                  
/** Recursive Query */
with 
    recursive aa(value_code, route) as (
		-- return initial row set
		select t.value_code, concat_ws('/', t.value_code) route from lfcp_system_dict t where t.category_code='INDUSTRIAL_CLASSIFICATION' and t.value_code in('A')
		union all
		-- return additional row sets
		select t2.value_code, concat_ws('/', t1.route, t2.value_code) route from aa t1 inner join lfcp_system_dict t2 on t1.value_code=t2.p_code 
	)
select * from aa t1 inner join lfcp_system_dict t2 on t1.value_code=t2.value_code where t2.category_code='INDUSTRIAL_CLASSIFICATION' ;

