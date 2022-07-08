
/********************************* Update ******************************************/
update tb
set col1=val1, col2=val2, col3=val3
where ;


update student
set (sname, sage, sbirthday, saddress)=(
    select '李四', 20, to_date('2010-01-01', 'yyyy-mm-dd'), '广州市越秀区' from dual  -- 注意此处只能返回单行值
)
where ;
