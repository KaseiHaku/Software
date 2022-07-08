-- 添加列
alter table tb add(
      col1 varchar2(2),
      col2 number(38,4)
);

-- 删除列
alter table tb drop(
    col1,
    col2
);

-- 修改列
alter table tb modify(
    col1 varchar2(23),
    col2 int
);

-- 重命名列
alter table tb rename column col1 to col2;
