/******************************* Data Type Cast ******************************
 * collate
 *  表示字符序，各个国家字符序不同，推荐使用 utf8mb4_unicode_ci 排序规则
 *  _ci(大小写不敏感), _cs(大小写敏感), _bin(表示用编码值进行比较)
 */
select binary 'aa' from dual;   -- 将字符串转换成 binary 类型
select cast(t.col as char character set utf8mb4 ) collate utf8mb4_bin from tb t; -- 将当前字符串转换成 utf8mb4 格式的字符串 
select cast(t.timestampCol at time zone '+00:00' as datetime[] ) from tb t;
select convert(t.col using utf8mb4 ) collate utf8mb4_bin  from tb t; -- 表示当前被转换的 字符串的字符集是 utf8mb4 
select convert(t.col, char character set utf8mb4) collate utf8mb4_bin  from tb t; -- 将当前字符串转换成 utf8mb4 格式的字符串 
/******************************* 流程控制函数 *******************************/
select 
    case [test] 
        when [val1] then [result]
        when [val1] then [result]
        when [val1] then [result]
        else [default] 
    end as alias
from tb;
/******************************* Date Interrelated ******************************
 */
select from_unixtime(1, '%Y-%m-%d %H:%i:%s.%f') from dual; -- 从 timestamp 转换成 datetime
select unix_timestamp('1970-01-01 08:00:01') from dual; -- 从 datestr 转成 timestamp
select date_format(now(), '%Y-%m-%d %H:%i:%s.%f') from dual; -- 格式化 datetime 到 datestr
select str_to_date('2020-06-24 12:12:12.000002', '%Y-%m-%d %H:%i:%s.%f') from dual; -- datestr 转 datetime


/******************************* JSON Interrelated ******************************
 * 官方文档：https://dev.mysql.com/doc/refman/8.0/en/json-function-reference.html
 */
select t.jsonCol, json_extract(t.jsonCol, "$.key") from tb t;
select t.jsonCol, t.jsonCol->"$.key" from tb t;            -- -> 等价于 json_extract()
select t.jsonCol, json_unquote(json_extract(t.jsonCol, "$.key")) from tb t;
select t.jsonCol, t.jsonCol->>"$.key" from tb t;            -- -> 等价于 json_unquote(json_extract())
update tb set jsonCol=json_set(jsonCol, '$.key', 'value', '$.key2', 'value2'); -- json_set()   有则更新，无则新增
json_array_append()  -- json 数组追加
json_array_insert()  -- json 数组插入
json_set()      -- json_set()   有则更新，无则新增
json_insert()        -- json 对象插入, 无则新增，有则保持原样
json_remove() -- json 对象，删除 key
json_replace() -- json 对象，替换 key，只替换已经存在
json_merge_preserve() -- json 对象合并，重复值保留原值
json_merge_patch()      -- json 对象合并，重复值更新
                                            
/******************************* BLOB Interrelated ******************************
 */
select cast(t.bolobCol as char character set utf8mb4 ) collate utf8mb4_bin from tb t; -- 将 blob 字段转成 字符串格式，再输出，适用于 blob 本身是 字符串的情况
select convert(t.bolobCol using utf8mb4 ) from tb t;  -- 同上
select to_base64(t.blobCol) from tb t; -- 将 blob 字段转成 base64 格式输出，适用于 blob 是文件的情况

if(test, arg1, arg2) -- 如果 test 为真，则返回 arg1，否则返回 arg2

ifnull(arg1, arg2)   -- 如果 arg1 不为 null 则返回 arg1，否则返回 arg2

nullif(arg1, arg2) -- 如果 arg1=arg2 返回NULL；否则返回arg1

-- 聚集函数
AVG(col)				-- 返回指定列的平均值
COUNT(col)				-- 返回指定列中非NULL值的个数
MIN(col)				-- 返回指定列的最小值
MAX(col)				-- 返回指定列的最大值
SUM(col)				-- 返回指定列的所有值之和
GROUP_CONCAT(col)			-- 返回由属于一组的列值连接组合而成的结果



-- 字符串函数
-- https://dev.mysql.com/doc/refman/5.7/en/string-functions.html
uuid() -- 生成一个 UUID

-- regular expression operator and function
NOT REGEXP	Negation of REGEXP
REGEXP	Whether string matches regular expression
RLIKE	Whether string matches regular expression

-- string compare operator and function
LIKE	Simple pattern matching
NOT LIKE	Negation of simple pattern matching
STRCMP()	Compare two strings

-- string deal function and operator
ASCII()	Return numeric value of left-most character
BIN()	Return a string containing binary representation of a number
BIT_LENGTH()	Return length of argument in bits
CHAR()	Return the character for each integer passed
CHAR_LENGTH()	Return number of characters in argument
CHARACTER_LENGTH()	Synonym for CHAR_LENGTH()
CONCAT()	Return concatenated string
CONCAT_WS()	Return concatenate with separator
ELT()	Return string at index number
EXPORT_SET()	Return a string such that for every bit set in the value bits, you get an on string and for every unset bit, you get an off string
FIELD()	Return the index (position) of the first argument in the subsequent arguments
FIND_IN_SET()	Return the index position of the first argument within the second argument
FORMAT()	Return a number formatted to specified number of decimal places
FROM_BASE64()	Decode base64 encoded string and return result
HEX()	Return a hexadecimal representation of a decimal or string value
INSERT()	Insert a substring at the specified position up to the specified number of characters
INSTR()	Return the index of the first occurrence of substring
LCASE()	Synonym for LOWER()
LEFT()	Return the leftmost number of characters as specified
LENGTH()	Return the length of a string in bytes
LIKE	Simple pattern matching
LOAD_FILE()	Load the named file
LOCATE()	Return the position of the first occurrence of substring
LOWER()	Return the argument in lowercase
LPAD()	Return the string argument, left-padded with the specified string
LTRIM()	Remove leading spaces
MAKE_SET()	Return a set of comma-separated strings that have the corresponding bit in bits set
MATCH	Perform full-text search
MID()	Return a substring starting from the specified position
NOT LIKE	Negation of simple pattern matching
NOT REGEXP	Negation of REGEXP
OCT()	Return a string containing octal representation of a number
OCTET_LENGTH()	Synonym for LENGTH()
ORD()	Return character code for leftmost character of the argument
POSITION()	Synonym for LOCATE()
QUOTE()	Escape the argument for use in an SQL statement
REGEXP	Whether string matches regular expression
REPEAT()	Repeat a string the specified number of times
REPLACE()	Replace occurrences of a specified string
REVERSE()	Reverse the characters in a string
RIGHT()	Return the specified rightmost number of characters
RLIKE	Whether string matches regular expression
RPAD()	Append string the specified number of times
RTRIM()	Remove trailing spaces
SOUNDEX()	Return a soundex string
SOUNDS LIKE	Compare sounds
SPACE()	Return a string of the specified number of spaces
STRCMP()	Compare two strings
SUBSTR()	Return the substring as specified
SUBSTRING()	Return the substring as specified
SUBSTRING_INDEX()	Return a substring from a string before the specified number of occurrences of the delimiter
TO_BASE64()	Return the argument converted to a base-64 string
TRIM()	Remove leading and trailing spaces
UCASE()	Synonym for UPPER()
UNHEX()	Return a string containing hex representation of a number
UPPER()	Convert to uppercase
WEIGHT_STRING()	Return the weight string for a string


