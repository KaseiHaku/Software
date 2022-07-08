/************************************ String Funciton ******************************************/
''                              -- 两个单引号，前面一个单引号作为转义符         
'111'||'222'                    -- 连接字符串，该结果为 '111222'
concat(str1, str2)              -- 连接字符串   

trim(str)                       -- 去除字符串首尾的空白字符
length('源串')                   -- 返回 源串的字符个数
instr('源串', '匹配串', '忽略源串前n个字符', '返回第n次出现的匹配串位置')  -- 返回指定匹配串在源串中的位置
substr(str, position, len)      -- 截取字符串，position 为正，从左到右截取 len 个字符串，否则从右到左

sys_guid()                      -- 生成一个不带 - 的 32 位 uuid

decode(columnname, 值1, 翻译值1, 值2, 翻译值2, ...值n, 翻译值n, 缺省值)        --如果columnname=值1，则返回翻译值1，以此类推，如果都不等于，则返回缺省值
nvl(e1, e2)         --如果e1 为 null，则函数返回 e2，否则返回 e1 本身
nvl(e1, e2, e3)     --如果e1 为 null，则函数返回 e3，否则返回 e2 

sign(val) -- 如果 val>0 返回 1；如果 val<0 返回 -1；如果 val=0 返回 0

to_number('$-00,100.3', 'L-00,999.9')                       --oracle: 字符串 转 number 函数; L 本地货币符号 $ 显示美元符号 
to_char(-23.870, 'FM0999.999')
to_char(+00123.870, 'LS00999D999')
/* 术语说明(onym explain)：
 *      本地化：指可以自己设定改符号使用的字符
 * 参数列表(parameter explain)：
 *      0   在对应位置返回对应的字符,如果没有则以'0'填充
 *      9   在小数位,则表示转换为对应字符,如果没有则以0表示;在整数位,没有对应则不填充字符.
 *      .   小数点
 *      S   带负号的负值（本地化，只能放首尾）
 *      FM  删除因9带来的空格
 *      D   小数点（本地化）
 *      L   货币符号（本地化）
 */


/************************************ Date Function ******************************************/
select current_date from dual;                  -- current_date 返回的是当前会话时间
select sysdate from dual;                       -- sysdate 返回的是安装 oracle 数据库的操作系统的时间
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') from dual;                  --oracle: 日期 转 字符串 函数
select to_date('1994-04-01 00:52:37','yyyy-mm-dd hh24:mi:ss') from dual;     --oracle: 字符串 转 日期 函数

select (createDate + INTERVAL '1' YEAR) as cDate from tb;   -- 日期 +1 年
select (createDate + INTERVAL '1' MONTH) as cDate from tb;  -- 日期 +1 月
select (createDate + INTERVAL '1' DAY) as cDate from tb;    -- 日期 +1 日
select (createDate + INTERVAL '1' HOUR) as cDate from tb;   -- 日期 +1 时
select (createDate + INTERVAL '1' MINUTE) as cDate from tb; -- 日期 +1 分
select (createDate + INTERVAL '1' SECOND) as cDate from tb; -- 日期 +1 秒



/************************************ 聚合函数 ******************************************/
count()
sum()
avg()
max()
min()

/************************************ 开窗函数 ******************************************/
-- oracle 分析函数：注意分析函数返回的是多行
sum(col1, col2)over(partition by col1, col2 order by col3 desc rows between unbounded preceding and unbounded following nulls last) 
--partition by : 对窗口内的数据按指定列进行分组
--order by : 对窗口内数据按指定列进行排序
--rows：指定窗口，注意 unbounded preceding，unbounded following 如果有partition by的话，是指分组后的第一行和最后一行
rows between unbounded preceding and unbounded following  -- 第一行 到 最后一行
rows between current row and unbounded following --当前行 到 最后一行
rows between 1 preceding and 2 following --当前行前一行 到 当前行后两行
rows between 1 preceding and current row --当前行前一行 到 前行

/************************************ 分析函数 ******************************************/
row_number()
rank()
dense_rank()
ntile()



/************************************ 其他函数 ******************************************/
/* Oracle 查看一个实例（对象） DDL 语句的 SQL，坑：参数中必须全部大写 */
select dbms_metadata.get_ddl('objectType', 'objectName', 'schema', 'version', 'model', 'transform') from dual;








