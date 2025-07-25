/******************************* Insert *******************************/



/******************************* Delete *******************************/


/******************************* Update *******************************/


/******************************* Select *******************************/
select * from cert where id between -1000125 and -1000012; -- @trap between and 前面的值，必须小于后面的值，否则查不到数据
-- 时间字段格式化 or 插入时的格式
select to_char(create_time AT TIME ZONE 'Asia/Shanghai', 'YYYY-MM-DD HH24:MI:SS.MS') from user_ext t where t.update_time> timestamp with time zone '1999-01-08 04:05:06.123+08';

select to_number('123.4', '000000.00'); -- 字符串转数字

-- 开窗函数演示
select
  row_number() over(order by t1.id desc rows between unbounded preceding and unbounded following) row_num,
  id
from tb t1;




