/* MySQL 表连接类型 */
from tb1, tb2 on                -- 等价于 inner join
from tb1 full join tb2 on       -- 不支持，使用 left join union right join 替代
from tb1 left join tb2 on 
from tb1 right join tb2 on 
from tb1 inner join tb2 on 


/* 查询 */
select col1, col2 
from t 
where 
order by convert(chinese using gbk) asc  -- mysql 中文排序需要使用 gbk 编码才是对的，否则会乱序
limit 100, 10; -- 从 100 行开始读取，一共读取 10 行



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
	WHERE id IN (SELECT id
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
-- 行转列，指把同一行中的不同列，转化到一个列中去
create table row2col(
	id int(8) auto_increment primary key,
	name varchar(8),
    gender varchar(8),
    chinese varchar(8),
    meth varchar(8),
    english varchar(8)
);
insert into `new2016`.`row2col` (`name`, `gender`, `chinese`, `math`, `english`) values ('小明', '男', '44', '54', '64');
insert into `new2016`.`row2col` (`name`, `gender`, `chinese`, `math`, `english`) values ('小红', '女', '66', '76', '86');
insert into `new2016`.`row2col` (`name`, `gender`, `chinese`, `math`, `english`) values ('小皮', '男', '78', '88', '98');

-- 基本思路：多次调用 select into 语句到中间表
select 
	name,
	gender,
	'语文',
	score
into templateTable
from row2col;


-- 列转行，指把一个列中的不同行且不相同的数据，分配到不同的列上去
create table col2row(
	id int(8) auto_increment primary key,
	name varchar(8),
    gender varchar(8),
    subject varchar(8),
    score varchar(8)
);
insert into col2row(name, gender, subject, score) values('小明', '男', 'chinese', '34');
insert into col2row(name, gender, subject, score) values('小明', '男', 'math', '34');
insert into col2row(name, gender, subject, score) values('小明', '男', 'english', '34');
insert into col2row(name, gender, subject, score) values('小红', '女', 'chinese', '34');
insert into col2row(name, gender, subject, score) values('小皮', '男', 'chinese', '34');

-- 方法1
select
    name,
    gender,
    sum(if(subject='chinese', score, 0)) as '语文',
    sum(if(subject='math', score, 0)) as '数学',
    sum(if(subject='english', score, 0)) as '英语'
from col2row
group by name, gender;

-- 方法2，推荐
select
	name,
    gender,
    max(case subject when 'chinese' then score else 0 end) as '语文',
    max(case subject when 'math' then score else 0 end) as '数学',
    max(case subject when 'english' then score else 0 end) as '英语'
from col2row
group by name, gender;

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




/* 常用 sql */
select 	
    max(case roh when 1 then COLUMN_NAME else 0 end) as z1
from 
(select @rowno:=@rowno+1 roh, COLUMN_NAME from information_schema.COLUMNS, (select @rowno:=0) t2 where table_name = 'discipline_school') t3;


