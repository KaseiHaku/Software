-- 创建一个无名的存储过程，仅供一次执行，不保存
declare 
    <declarations section>      -- 变量声明
begin
    <executable command(s)>     -- 执行命令
exception
    <exception handling>        -- 异常处理
end;

-- 创建一个命名的存储过程
create or replace procedure schema1.pro1(param1 in nocopy varchar2 default 'df'||'gh', param2 out number(38,4), param3 in out timestamp) authid [current_user | definer] 
is|as -- 创建视图时只能用 as ；声明游标时只能用 is   

    -- 基本类型
    var1 constant number(9,4) default 12345.6788;--定义 数字类型 的 列常量，并设置默认值 12345.6789
    var2 varchar2(23) not null := 'qwer'; --定义 字符串类型 的 列变量，并赋初值 'qwer'   
    var3 boolean default := false;--定义 布尔类型 的 列变量
    var4 date default sysdate;--定义 日期类型 的 列变量
    var5 tabName.colName%type;--引用型：表示列变量colVar4的类型跟tabName表中colName列相同

    
    -- 行
    rowVar1 tabName%rowtype;    -- 定义一个行变量：表示 rowVar1 的结构跟 tabName 表中的行结构相同
    rowVar2 cursorName%rowtype; -- 定义一个行变量：表示 rowVar2 的结构跟 cursorName 返回的结构一样
    type rowType1 is record(-- 记录类型：相当于C语言中的 struct 类型，定义的不是变量，而是一个自定义类型
        fieldName1 dataType not null default defaultValue,
        fieldName2 dataType not null default defaultValue,
        fieldName3 dataType not null default defaultValue
    ); 
    
    rowVar3 rowType1;-- 定义一个行变量
    
    -- 表
    type tabType1 is table of(-- 定义表类型：相当于行的数组
        rowVar not null default index by binary_integer,-- index by binary_integer 指示系统创建一个主键索引，以引用记录表变量中的特定行
        rowVar not null default index by binary_integer,
        rowVar not null default index by binary_integer
    );
    tabVar tabType1;--定义一个表变量
    
    -- 游标
    cursor cursorName(arg1 number, arg2 varchar2(3)) is select aa, bb from tabName where aa>arg1 and bb=arg2; -- 定义一个带参数的游标，可以用来对查询条件的参数化
    type cursorType1 is ref cursor;-- 定义一个弱类型的游标类型，
    type cursorType2 is ref cursor(return returnType);-- 定义一个强类型的游标类型，如果写 returnType，则表示该游标是一个强类型的游标变量，即该游标的返回值是固定的，与返回类型相同，returnType 可以是 行类型，或者列类型 
    cursorVar cursorType1;--定义一个游标变量 
    

    -- 自定义一个异常  
    myException exception;  

    -- 例子中使用的变量
    x number; 
    cursor myCursor is select ename from emp where deptno=50;  
    e_name emp.ename%type;     
    
begin
    --plsql执行语句
    x:=1/0;  

    open myCursor;     
    fetch mCursor into e_name ;  
    if mCursor%notfound then raise myException; --使用 raise 来抛出异常  
    end if;  
    close myCursor;  
    
    
    -- 2、打开游标
    open cursorName(20, 'asd');
    open cursorVar for select ename,sal from emp where deptno=30;-- 使用游标变量的时候，打开游标就要对游标赋值 
    loop
        -- 3、取值
        fetch cursorName into rowVar;-- 取一条记录到 rowVar 行变量中，
        dbms_output.put_line('数字='||rowVar.aa||'  字符='||rowVar.bb);-- 取行变量的值打印到屏幕
        execute immediate 'alter trigger trg_test disable'; -- 在存储过程中使用 DML 语句时，需要使用改格式执行
        exit when cursorName%notfound;-- 当游标结束时退出循环     
    end loop;
    -- 4、关闭游标
    close cursorName;
                                                 
                                                 
    -- for 循环使用 cursor，不需要打开和关闭游标，也不需要判断游标状态来退出循环
    for rowVar2 in cursorName loop
        dbms_output.put_line('Log = ' || rowVar.aa);                                          
    end loop;
    
exception
    --异常处理语句
    when Zero_Divide then dbms_output.put_line('除数不能为0'); --系统异常 Zero_Divide
    when others then dbms_output.put_line('其他例外');--不管什么异常都会被这个捕获  
    when  no_data_emp then dbms_output.put_line('没有此数据');  
end pro1;





-- 游标的属性
-- 游标初始指向第1行，每取一行游标自动指向下一行。
-- cursorName%isopen  --游标是否打开，打开返回true
-- cursorName%rowcount --影响的行数，返回number
-- cursorName%found --还有行？，有返回true
-- cursorName%notfound --没有行了？，没有返回true

fetch  cursorName into recordVar; --取得一条
fetch  cursorName  bulk collect into tabVar; --取得全部 
fetch  cursorName  bulk collect into tabVar limit 10; --取10条






-- Flow Control
if x>90 then dbms_output.put_line('成绩是优秀');
elsif x>60 then dbms_output.put_line('成绩是及格');
else dbms_output.put_line('成绩是不及格');
end if;


case str
when 'A' then dbms_output.put_line('选的是A');
when 'B' then dbms_output.put_line('选的是B');
else dbms_output.put_line('不知道选的是什么鬼东西');
end case; 

[LABLE]loop
    x:=x+1;
    if x>6 then exit; --跳出循环的语句
    dbms_output.put_line('x的值为'||x);
end loop[LABLE]

while x<9 loop  
    x:=x+1;
end loop;


loop
    x := x+1; 
    exit when x>9;
end loop;


[LABLE]for x in reverse 1..5 loop --reverse 表示取的顺序为 54321，否则为 12345
    dbms_output.put_line('x的值为'||x);-- || oracle 字符串连接操作符
end loop [LABLE]; 


[LABLE]
    x:=x+1;
    if x>6 then exit; --跳出循环的语句
    dbms_output.put_line('x的值为'||x);
goto [LABLE];




--删除过程
drop procedure pro1;

-- 调用存储过程
execute pro1(); -- 方式一：execute ，该语句是使用 plsql 执行的
call pro1(); -- 方式二： call 关键字调用，该语句是 sql 标准语句

begin   -- 方式三：在其他存储过程中调用
    pro1();
end;


