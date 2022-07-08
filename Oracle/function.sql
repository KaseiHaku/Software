-- create function
create or replace function func(param1 in varchar2 default 'aa'||'bb', param2 in number, param3 in out number) return varchar2
is|as
 [declare_section;]
begin
    ...;
    return expression;
exception
    ...;
    return expression;
end func;


--删除函数
drop function function_name;

--调用方式
var sal number
sal:=function_name(); -- 方式1： 给变量赋值

select function_name() from dual; -- 方式2： 作为 select 语句的函数

dbms_output.put_line('调用方式三：'||function_name()); -- 方式3： 当做函数的参数