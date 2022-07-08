/********************************* Select 语句执行顺序 ******************************************/
-- 以下 SQL 每一步都会生成一张虚拟表（Virtual Table）
from t1 left join t2        -- 取 t1 t2 的笛卡尔积，生成 VT1
on                          -- 在 VT1 中用 on 中的条件筛选出符合条件的行，生成 VT2
left | right | full         -- 保留表中未找到匹配的行将作为外部行添加到 VT2，生成 VT3，多个 join 顺序执行，使用上一个 join 的结果表
where                       -- 从 VT3 中筛选出符合条件的行，生成 VT4
group by                    -- 将 VT4 按指定条件分组，生成 VT5
cute | rollup               -- 把超组插入 VT5，生成 VT6
having                      -- VT6 中将组按指定条件筛选，将符合条件的行插入 VT7
select                      -- 处理 VT7 中的每一行数据生成 VT8
distinct                    -- 将 VT8 中重复的行删除，生成 VT9
union                       -- 结合另一个查询，生成 VT10
order by                    -- 将 VT10 按指定的列排序 ascend 升序，descend 降序，生成 VT11
top                         -- 从 VT11 中选取指定数量或比例的数据，生成 VT12 返回给用户

-- 高级应用
partition by        -- 效果跟 group by 相似，但 group by 只能用聚集函数取一个值，partition by 分组之后还是多个值，每个组相当于独立的一张表


/********************************* select ... for update 语句 ******************************************/
select ... for update [of columnList] [wait n|nowait] [skip locked];
select * from person for update; -- 获取资源，并对所获取的资源加 行级锁，如果资源被其他人占用，则无限等待
select * from person for update nowait; -- 获取资源，并对所获取的资源加 行级锁，如果资源被其他人占用，则不等待

select * from person for update wait 3; -- 获取资源，并对所获取的资源加 行级锁，如果资源被其他人占用，则等待 3 秒

select * from person for update skip locked; -- 获取资源，并对所获取的资源加 行级锁，如果资源被其他人占用，则跳过被占用的资源，即不显示被占用的资源
select * from person a left join person_asset b on a.id=b.person_id for update of a.gender; -- 多表查询时（单标操作时，跟 for update 没有区别），只锁定 of 后面列所在的表，该锁也是行级锁

select t.rowid, t.* from tab t; -- 在 pl/sql 中同样能实现修改功能，但是该语句不加锁

-- case when then else end 语法
select 
t.name,
(
    case
    when t.gender=1 then '男'
    when t.gender=2 then '女'
    else '空'
    end
) sex 
from person t;

-- decode 函数
select t.name, decode(t.gender, 1, '男', 2, '女', '空') sex from person t;


/********************************* Comparison Conditions ******************************************/
>, <, >=, <=, !=
like, not like
is null, is not null
between and 

col > any(subQuery)
col in(subQuery)        -- in 的效率比多个 or 连接的效率要高，如果数据量大，使用 exist 效率更高
col > some(suQuery)

col < all(subQuery)

exist(subQuery)         -- 如果子查询中有记录，那么表达式为 true，exist 肯定是相关子查询








/********************************* select 案例 ******************************************/
select distinct col1 as alias1, col2 as alias2
from tab as t1 left join tab2 as t2 on(t1.col1=t2.col1, t1.col2=t2.col2)
where t1.col1>30
group by(col1, col2) having(col1>2)
order by col1 desc nulls last, col2 asc, nlssort(col3, 'NLS_SORT=SCHINESE_PINYIN_M');;

-- 表连接
t1 inner join t2    -- t1 和 t2 做笛卡尔积，然后在笛卡尔积中返回符合条件的行，且仅返回匹配的行
t1 left join t2     -- t1 和 t2 做笛卡尔积，然后在笛卡尔积中返回符合条件的行，且即使 t2 中没有匹配，也从 t1 返回所有的行
t1 right join t2    -- t1 和 t2 做笛卡尔积，然后在笛卡尔积中返回符合条件的行，且即使 t1 中没有匹配，也从 t2 返回所有的行
t1 full join t2     -- t1 和 t2 做笛卡尔积，然后在笛卡尔积中返回符合条件的行，且即使没有匹配，也从 t1、t2 返回所有的行
t1 cross join t2    -- t1 和 t2 做笛卡尔积，直接返回所有结果，即: 没有 on 语句

-- 子查询
-- 嵌套查询:将一个查询块嵌套在另一个查询块的where子句或者having短语的条件中的查询，子查询不能使用order by 
-- 多列子查询适应于：成对比较；
-- 组比较： any some all
select 
from
where (Sno,Cno)>any(
    select a,b
    from 
);

-- 基于派生表的查询:用于子查询多个列被使用的情况
select 
from tab1, (select aa, bb from tab2) as t2(aa2, bb2)
where tab1.hh=t2.yy;

-- 相关子查询：
-- 执行过程：
-- 1.从外层查询中取出SC的一个元组x，将x.Sno的值传入子查询
-- 2.执行子查询，得到结果，用结果代替子查询得到外层查询，将外层查询结果写入结果集，即展示界面
-- 3.重复执行1 2 直到所有元组遍历完成
select Sno,Cno
from SC x /*x是表SC的别名，又称为元组变量，可以用来表示SC的一个元组*/
where Grade >= (
    select AVG(Grade)
    from SC y
    where y.Sno = x.Sno
);

-- 分页查询
select * 
from (
    select rownum rn, t.*
    from tabName t
    where col>10 and rownum<=40;
) tab1
where tab1.rn>=10


-- 取 group by 以外的其他字段的值，思路一，group by 之后与原表 join
select * 
from student t1 left join 
     (select age, max(height) from student group by age ) t2 on t1.age=t2.age and t1.height=t2.height;

-- 取 group by 以外的其他字段的值，思路二,使用 rownum 伪列
select rownum, age, height from student where rowid=1 order by height;



-- with as 语法：相当于定义了一个表变量，只是oracle内部处理的时候不一样
with 
    tab1 as ( <子查询> ),      --相当于创建表变量 tab1 并用子查询赋值
    tab2 as ( <子查询> )
select * from tab1 left join tab2; -- 用创建的别名写 sql



/*********************************************** 行列转换 ****************************************************/
-- 合并多列到一列
with
aa as (
   select 1 p_id, 'kasei' p_name, 23 age from dual
)
-- select p_id, concat(p_name, age) combined from aa  -- 方式一
select p_id, p_name||age combined from aa         -- 方式二
;

-- 拆分一列到多列
with
aa as (
   select 'kasei' p_name, 'math=32,english=23,' grade from dual
)
select 
  p_name, 
  substr(
      grade, 
      0, 
      instr(grade, ',', 1, 1)-1
  ) math,
  substr(
      grade, 
      instr(grade, ',', 1, 1)+1, 
      instr(grade, ',', 1, 2)-1-instr(grade, ',', 1, 1)
  ) english,
  instr(grade, ',', 1, 2) position
from aa
;


-- group by 合并同一个分组的指定列内容到一行
with
aa as (
   select 'kasei' p_name, 'math=83' grade from dual
	 union
	 select 'kasei' p_name, 'engilish=23' grade from dual
)
select p_name, listagg(grade, ',') within group(order by grade) as ageList
from aa
group by p_name
;


                              
/** todo 拆分一行到多行 */
/** Hierarchical Queries 层级查询
 * syntax:    start with <condition1> connect by [nocycle] <condition2>
 * illustrate： 
 *      start with：以表中所有符合 condition1 条件的行作为 tree 的 root 节点，如果 condition2 成立那么把符合条件的行追加到结果集中
 *      parentId = prior id : 
 *          表示 上一层(第1层) 的 id 等于 当前层(第2层) 的 parentId; 所以表示的意思是 第1层的是根，第2层的是叶子
 *      prior parentId = id： 
 *          表示 上一层(第1层) 的 parentId 等于 当前层(第2层) 的 id; 所以表示的意思是 第1层的是叶子，第2层的是根
 * CONNECT_BY_ROOT： 伪列，类似与 rowid, rownum 用于表示当前行是哪棵树下的行
 * CONNECT_BY_ISCYCLE: 伪列，用于表示，如果节点存在闭环，则显示 1
 * level 关键字：表示当前所在的层级
 * */
-- 方法一： 使用层级查询
with 
  temp as (
    select '11' as x  from dual
    union select '222' as x  from dual
  ）
select x, level 
from temp t connect by level<=length(t.x) and prior x=x and prior sys_guid() is not null;
 
-- 层级查询 demo
with 
  temp as (
    select 'id1' as kasei, '1,11,111' as x  from dual
    union 
    select 'id2' as kasei, '22,222' as x  from dual
    union
    select 'id3' as kasei , '' as x from dual
  ),
  -- 获取分隔符有多少项
  aa as (select t.kasei, t.x, length(t.x || ',')-nvl(length(replace(t.x, ',')),0) max_len from temp t),  
  -- 生成跟分隔项相同行数的数据
  bb as (select t.kasei, t.x, t.max_len, level as lvl from aa t connect by level<=max_len and prior kasei=kasei and prior dbms_random.value is not null),
  -- 分隔出数据
  cc as (select t.kasei, t.x, t.max_len, lvl, regexp_substr(t.x, '[^,]+', 1, t.lvl) eventually from bb t)
select * from cc;

-- 方法二：使用 recursive subquery factoring, Oracle 11g 朝上
with 
  temp as (
    select '11' as x  from dual
    union select '222' as x  from dual
  ),
  recursive (x, x_index, len) as (
    select x, 1, length(x) from temp
    union all
    select r.x, r.x_index + 1, r.len from recursive r
    where r.x_index < r.len
  )
select x from recursive
order by x;
                         
-- 递归子查询因式分解 方式 Demo
with 
  temp as (
    select 'id1' as kasei, '1,11,111' as x  from dual
    union 
    select 'id2' as kasei, '22,222' as x  from dual
    union
    select 'id3' as kasei , '' as x from dual
  ),
  recursive (kasei, x, x_index, max_len) as (
    select t.kasei, t.x, 1, length(t.x || ',')-nvl(length(replace(t.x, ',')),0) max_len from temp t
    union all
    select r.kasei, r.x, r.x_index+1, r.max_len from recursive r
    where r.x_index < r.max_len
  ),
  res as(select t.kasei, t.x, t.x_index, t.max_len, regexp_substr(t.x, '[^,]+', 1, t.x_index) eventually from recursive t)
select * from res order by x;
      

-- 多列转多行
with 
aa as (     -- 初始数据构建
  select 1 "P_ID", 22 "kasei", 18 "haku" from dual
),
bb as (     -- 实现方式一
  select p_id, 'kasei' p_name, "kasei" age from aa
  union
  select p_id, 'haku' p_name, "haku" age from aa
),
cc as (     -- 实现方式二
  select p_id, p_name, age
  from aa unpivot(age for p_name in("kasei", "haku")) -- 将原表中的 ["kasei", "haku"] 几个列值，当做 age 列的值展示，并将对应的列名放入到 p_name 列的列值中 
)
select * from cc
;
                                                   

-- 多行转多列
with 
aa as(
  -- 初始数据构建
  select 'kasei' p_name, 'math' subject, 32 score from dual
  union
  select 'kasei' p_name, 'english' subject, 54 score from dual
  union
  select 'haku' p_name, 'chinese' subject, 99 score from dual
),
bb as (
  select 
	p_name,
    max(decode(subject, 'math', score, -1)) as math, 
    max(decode(subject, 'english', score, -1)) as english,
    max(decode(subject, 'chinese', score, -1)) as chinese
  from aa 
  group by p_name
),
cc as (
   select * from aa pivot(max(score) for subject in('math', 'english', 'chinese'))
)
select * from bb
;

                         
                         
/******************************** xmltype 数据类型操作 ********************************/
/** 常用函数
 * xmlserialize()   将 xmltype 类型的数据转换为 clob
 * xmlcast()        将 xmltype 类型的数据转换为 指定类型
 * xmlparse()       将 clob 类型的数据转化为 xmltype
 * xmlquery()       查询 xmltype 类型
 * */           
select t.ofcappdate, t.RmarkOFC, t.xmldata,
xmlserialize(
    content 
    xmlquery(      
        'for $x in /Items/WFItem[@name="RmarkFFBuyer"][1] return fn:data($x)'       
         passing by value xmlparse(document t.xmldata wellformed) returning content null on empty    
    ) 
as clob) aa,
xmlquery('/Items/WFItem[@name="OtherOFC"]' passing xmlparse(document t.xmldata wellformed) returning content) bb,
xmlcast( xmltypedata as varchar2(400)) -- 将 xmltype 类型的数据转化成 varchar2
from table1 t ;                       
