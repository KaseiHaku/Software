/* Oracle(regular expression)简单介绍 */

regexp_like('源串', '正则表达式', 'inm')       -- 与like 操作符相似。如果第一个参数匹配正则表达式它就解析为true。
regexp_instr('源串', '正则表达式', '源串前n位不参与匹配', '返回第n次出现的匹配串位置', '返回选项：0匹配串首字符位置；1匹配串尾字符位置', matchMode)
regexp_substr('源串', '正则表达式', '源串前n位不参与匹配', '返回第n次出现的匹配串', matchMode)
regexp_replace('源串', '正则表达式', '替换串', '源串前n位不参与匹配', '替换第n次出现的匹配串', matchMode)

matchMode 有以下几种
i   -- 大小写不敏感；
c   -- 大小写敏感；
n   -- 点号 . 不匹配换行符号；
m   -- 多行模式；
x   -- 扩展模式，忽略正则表达式中的空白字符。


2.Oracle正则特殊字符

'^'     匹配输入字符串的开始位置，在方括号表达式中使用，此时它表示不接受该字符集合。
'$'     匹配输入字符串的结尾位置。如果设置了 RegExp 对象的 Multiline 属性，则 $ 也匹配 '\n' 或'\r'。
'.'     匹配除换行符 \n之外的任何单字符。
'?'     匹配前面的子表达式零次或一次。
'*'     匹配前面的子表达式零次或多次。
'+'     匹配前面的子表达式一次或多次。
'()'    标记一个子表达式的开始和结束位置。
'[]'    标记一个中括号表达式。
'{m,n}' 一个精确地出现次数范围，m=<出现次数<=n，'{m}'表示出现m次，'{m,}'表示至少出现m次。
'|'     指明两项之间的一个选择。例子'^([a-z]+|[0-9]+)$'表示所有小写字母或数字组合成的字符串。
\num    匹配 num，其中 num 是一个正整数。对所获取的匹配的引用。

正则表达式的一个很有用的特点是可以保存子表达式以后使用，被称为 Backreferencing。
允许复杂的替换能力 如调整一个模式到新的位置或者指示被代替的字符或者单词的位置。
被匹配的子表达式存储在临时缓冲区中，缓冲区从左到右编号, 通过\数字符号访问。

下面的例子列出了把名字 aa bb cc 变成cc, bb, aa.
Select REGEXP_REPLACE('aa bb cc','(.*) (.*) (.*)', '\3, \2, \1') FROM dual； REGEXP_REPLACE('ELLENHILDISMIT cc, bb, aa'\' 转义符)


3.Oracle正则字符簇

[[:alpha:]] 任何字母。
[[:digit:]] 任何数字。
[[:alnum:]] 任何字母和数字。
[[:space:]] 任何白字符。
[[:upper:]] 任何大写字母。
[[:lower:]] 任何小写字母。
[[unct:]] 任何标点符号。
[[:xdigit:]] 任何16进制的数字，相当于[0-9a-fA-F]。
[:cntrl:]    控制字符（禁止打印）  


4.各种操作符的运算优先级

\ 转义符
(), (?:), (?=), (?!), [] 圆括号和方括号
*, +, ?, {n}, {n,}, {n,m} 限定符
^, $, \anymetacharacter 位置和顺序
| “或”操作


5.模拟测试例子

--测试数据
create table test(mc varchar2(60)); 
insert into test values('112233445566778899'); 
insert into test values('22113344 5566778899'); 
insert into test values('33112244 5566778899'); 
insert into test values('44112233 5566 778899'); 
insert into test values('5511 2233 4466778899'); 
insert into test values('661122334455778899'); 
insert into test values('771122334455668899'); 
insert into test values('881122334455667799'); 
insert into test values('991122334455667788'); 
insert into test values('aabbccddee'); 
insert into test values('bbaaaccddee'); 
insert into test values('ccabbddee'); 
insert into test values('ddaabbccee'); 
insert into test values('eeaabbccdd'); 
insert into test values('ab123'); 
insert into test values('123xy'); 
insert into test values('007ab'); 
insert into test values('abcxy'); 
insert into test values('The final test is is is how to find duplicate words.'); 
commit;

-- REGEXP_LIKE
select * from test where regexp_like(mc,'^a{1,3}'); 
select * from test where regexp_like(mc,'a{1,3}'); 
select * from test where regexp_like(mc,'^a.*e$'); 
select * from test where regexp_like(mc,'^[[:lower:]]|[[:digit:]]'); 
select * from test where regexp_like(mc,'^[[:lower:]]'); 
Select mc FROM test Where REGEXP_LIKE(mc,'[^[:digit:]]'); 
Select mc FROM test Where REGEXP_LIKE(mc,'^[^[:digit:]]');

-- REGEXP_INSTR
Select REGEXP_INSTR(mc,'[[:digit:]]$') from test; 
Select REGEXP_INSTR(mc,'[[:digit:]]+$') from test; 
Select REGEXP_INSTR('The price is $400.','\$[[:digit:]]+') FROM DUAL; 
Select REGEXP_INSTR('onetwothree','[^[[:lower:]]]') FROM DUAL; 
Select REGEXP_INSTR(',,,,,','[^,]*') FROM DUAL; 
Select REGEXP_INSTR(',,,,,','[^,]') FROM DUAL;
c.REGEXP_SUBSTR

-- REGEXP_SUBSTR
SELECT REGEXP_SUBSTR(mc,'[a-z]+') FROM test; 
SELECT REGEXP_SUBSTR(mc,'[0-9]+') FROM test; 
SELECT REGEXP_SUBSTR('aababcde','^a.*b') FROM DUAL;

-- REGEXP_REPLACE 
Select REGEXP_REPLACE('Joe Smith','( ){2,}', ',') AS RX_REPLACE FROM dual; 
Select REGEXP_REPLACE('aa bb cc','(.*) (.*) (.*)', '\3, \2, \1') FROM dual;
select regexp_replace('string', '[:cntrl:]', '', 1, 0, 'inm') from dual; -- 替换掉所有控制字符
                                    
                                    

