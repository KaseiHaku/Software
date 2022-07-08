/* Neo4j Data Type */
String values
Numeric values
Boolean values
Lists of any of the above values

/********************************* Neo4j CQL **********************************/
// 单行注释采用 双斜杠
-- naming convention：node name = camel   relation name = upcase


/* Case Syntax */
match(Person:Person)
return Person.age as '名字',  -- return 相当于 sql 中的 select 只是放到了语句末尾; as 取别名
    case person.name
        when 'Kasei' then 'Master'
        when 'Haku' then 'Servant'
        else null -- 没有匹配的值默认返回 null 
    end as '描述';


/* Node Syntax */
(a:Person:User{name:'Kasei', wife:'Haku', age:22})


/* Relation Syntax */
(a)--(b)
(a)-[r:REL_TYPE*3..5{blocked:false}]->(b)

p = (a)-[*3..5]->(b)  -- 为一个 path 指定名称为 p


-- 概念梳理
-- 节点(Node)：MySQL 中一张表中的一个记录就是一个节点，而不是一张表才是一个节点
-- 标识(Label)：用于把不同的节点归属到一个组里面，一个节点有多个 Label
-- 关系(Relation)：
-- 关系


 

-- 创建节点
create(:User{account:"520", nickName:"Kasei", gender:"Man"});
-- 删除节点
match(n) detach delete n;
-- 查询节点
match(n:User{account:"520"}) where nickname is null return n;


-- 创建索引
create index on :User(account, nickName);
-- 删除索引
drop index on :User(account, nickName);
-- 查询索引
call db.indexes;


-- 创建约束条件
create constraint on (n:User) assert n.account is unique; -- 创建一个属性的唯一性约束，只能支持一个属性

create constraint on (n:User) assert exists(n.account); -- 创建一个节点的属性的存在性约束
create constraint on ()-[r:LIKED]-() assert exists(r.day); -- 创建一个关系的属性的存在性约束

create constraint on (n:User) assert (n.firstname, n.surname) is node key; -- 创建一个节点主键

-- 删除约束条件
drop constraint on (n:User) assert n.account is unique; 

drop constraint on (n:User) assert exists(n.account);
drop constraint on ()-[r:LIKED]-() assert exists(r.day);

drop constraint on (n:User) assert (n.firstname, n.surname) is node key;

-- 查询所有约束条件
call db.constraints;

-- 创建标签
match(n:User{nickName:"Kasei"})
set n:Person:Label
return id(n), n.nickName, labels(n) as labels;

-- 删除标签
match(n:User{nickName:"Kasei"})
remove n:Person:Label
return n.nickName, labels(n) as labels;

-- 查询所有标签
call db.labels();


-- 创建关系
match (a:Person), (b:Person)
where a.name = 'a' and b.name = 'b'
create (a)-[r:RELTYPE{ name: a.name + '-RELTYPE->' + b.name }]->(b)
return type(r), r.name;

-- 删除关系
match (n { name: 'andres' })-[r:KNOWS]->()
delete r

-- 修改关系
match (n { name: 'andres' })-[r:KNOWS]->()
set r.degree="很熟"




-- 创建及修改属性
match(n:User{nickName:"Kasei"})
set n.age=22, n.wife="Haku";

-- 删除属性
match(n:User{nickName:"Kasei"})
remove n.account
return n.account, n.nickName;

match(n:User{nickName:"Kasei"})
set n.age=null, n.wife=null;

-- 查询属性
match(n)
where 

/*
and
or
xor
not

n.age < 32
n.age > 32
n.age = 32
n.account >= "abcd"
n.account <= "abcd"
n.account in ["aa", "bb"]
n.account is null


exsits(n.account)

starts with
ends with
contains




正则表达式 
=~ '(?i)Lon.*'                  
(?i)    默认情况下，大小写不明感的匹配只适用于US-ASCII字符集。这个标志能让表达式忽略大小写进行匹配。要想对Unicode字符进行大小不明感的匹配，只要将UNICODE_CASE与这个标志合起来就行了; 
(?u)    在这个模式下，如果你还启用了CASE_INSENSITIVE标志，那么它会对Unicode字符进行大小写不明感的匹配。默认情况下，大小写不敏感的匹配只适用于US-ASCII字符集;
(?m)    在这种模式下，'^'和'$'分别匹配一行的开始和结束。此外，'^'仍然匹配字符串的开始，'$'也匹配字符串的结束。默认情况下，这两个表达式仅仅匹配字符串的开始和结束; 
(?s)    在这种模式下，表达式'.'可以匹配任意字符，包括表示一行的结束符。默认情况下，表达式'.'不匹配行的结束符;
(?d)    在这个模式下，只有'\n'才被认作一行的中止，并且与'.'，'^'，以及'$'进行匹配;
(?x)    在这种模式下，匹配时会忽略(正则表达式里的)空格字符(译者注：不是指表达式里的"\\s"，而是指表达式里的空格，tab，回车之类)。注释从#开始，一直到这行结束。可以通过嵌入式的标志来启用Unix行模式;

*/











字符串函数：
UPPER(<input-string>)
LOWER(<input-string>)
SUBSTRING(<input-string>,<startIndex> ,<endIndex>)
REPLACE()

MATCH (e:Employee) 
RETURN e.id,UPPER(e.name),e.sal,e.deptno


聚合函数
COUNT()
MAX()
MIN()
AVG()
SUM()


关系函数
STARTNODE()
ENDNODE()
ID()
TYPE()


MATCH (a)-[movie:ACTION_MOVIES]->(b) 
RETURN STARTNODE(movie)


创建唯一性约束
CREATE CONSTRAINT ON (<label_name>)
ASSERT <property_name> IS UNIQUE

删除唯一性约束
DROP CONSTRAINT ON (<label_name>)
ASSERT <property_name> IS UNIQUE
