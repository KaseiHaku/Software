 /************************************************* mysql 变量 ***********************************************************/
-- 变量主要有以下几种类型：local, user, session, global

-- Local Variable
-- 局部变量一般用在 sql 语句块，比如存储过程的 begin/end. 其作用域仅限于该语句块，语句块执行完毕，则局部变量消失
drop procedure if exists localVariable; 
delimiter $$
create procedure localVariable()
begin
    declare var1 int(8) default 0; -- 定义局部变量
    select var1; -- 使用局部变量
    set var1 = 9; -- 修改局部变量
    
end
$$ delimiter;


-- User Variable
-- 用户变量作用于当前整个连接，当当前连接断开后，所有用户变量都将消失
drop procedure if exists sessionVariable; 
delimiter $$
create procedure sessionVariable()
begin
    set @var1 = 9; -- 定义会话变量
    select @var1:=(1+2) as var1; -- 使用会话变量
    
end
$$ delimiter;


-- Session Variable
-- 服务器使用当前相应的全局变量，对当前连接的客户端的会话变量做初始化，客户端能且只能更改自己的会话变量，
-- 会话变量的作用域和用户变量一样，仅作用域当前连接
set session var2 = 'haku';-- 设置会话变量，方式二
set @@seesion.var1 = 8; -- 设置会话变量，方式一
set var3 = 2.17;-- 设置会话变量，方式三


select @@session.var2; -- 查看会话变量，方式二
select @@var1; -- 查看会话变量，方式一
show session variables like '%var%'; -- 查看会话变量，方式三


-- Global Variable
-- 全局变量影响服务器整体操作，服务器启动时，从配置文件读取全局变量
-- 具有 super 权限才能修改，作用域服务器整个生命周期，不能跨重启
-- 定义全局变量
set global var2 = 2;
set @@global.var1 = 1;

-- 查看全局变量
select @@global.globalVar1;
show global variables like '%global%';


/************************************************* mysql 存储过程 ***********************************************************/
-- 查看所有存储过程、存储函数
show procedure status;
show function status;    

select `name` from mysql.proc where db = 'your_db_name' and `type` = 'PROCEDURE'; -- root 权限
select `name` from mysql.proc where db = 'your_db_name' and `type` = 'FUNCTION'  

show create procedure proc_name; -- 查看存储过程创建代码
show create function func_name; -- 查看存储函数创建代码





-- 定义输入结束符
delimiter $$ 
-- 定义存储过程
create procedure param(

	in var1 int(9),			-- 输入
	inout var2 int(9),		-- 输入和输出

	out var3 varchar(255),	-- 输出
	out var4 int(9),
	out var5 decimal(9,2),	# ##
	out var6 datetime		/* */
)
begin
    /* 定义变量 */
	declare var7 int(7) default 8; 
    
    /* 给变量赋值 */ 
	set var7 = 9; 
	select name into var3 from order where id=1; -- 订单表
    select price into var4 from order where id=1; 
    select avg(price) into var5 from order; -- 给变量赋值
    
    /* 流程控制 及 变量使用 */
    -- if 语句格式
    if var7>9 then
    elseif var7<9 then
	end if;
	
	-- case 语句格式
	case var7
	when 1 then sql
	when 2 then sql
	else 
	end case;
	
	-- while 语句格式
	[begin_label:] WHILE search_condition DO
        statement_list
    END WHILE [end_label]
	
	
	LOOP1:
	while var7<9 do
		set var7=var7+1;
		iterate LOOP1  -- 相当于 continue
		leave LOOP1 -- 相当于 break
	end while
	LOOP1;
	
	-- repeat 语句格式
	[begin_label:] REPEAT
        statement_list
    UNTIL search_condition
    END REPEAT [end_label]
	
	LOOP2:
	repeat
		set var7=var7+1;
	until var7>9
	end repeat
	LOOP2 ;
	
	-- loop 语句格式
	label1: LOOP
        SET p1 = p1 + 1;
        IF p1 < 10 THEN
          ITERATE label1;
        END IF;
        LEAVE label1;
    END LOOP label1;
	
    dbms_output.put_line(re); -- 输出到控制台日志
end;
$$
delimiter ;





-- 存储函数
CREATE FUNCTION sp_name([func_parameter[,...]]) 
RETURNS type 
[characteristic ...] routine_body 
Return


---------------------------------------------------------------------------------------------




/* 存储过程 */
-- 删除存储过程
drop procedure if exists demo; 

-- 创建存储过程
delimiter $$
create procedure demo(in param1 int(8), out param2 varchar(8), inout param3 decimal(4,2))
begin	
	
    declare var2 int(2);
    declare var3 int(4);
    declare var4 int(8);
    
	/* 定义变量 */
	declare var1 int(8) default 0; -- 定义变量
    declare done int(2) default 0; -- 定义游标结束标志
	declare cursorVar cursor for select resource_id, wrong_id, type from r_resource_wrong; -- 定义游标变量
    declare continue handler for sqlstate '02000' set done = 1;
    
	-- 给变量赋值
	set var1 = 2;
    set param1 = param3; -- 使用参数以及给参数赋值
			
	/* 打印变量 */
	select param1, param2, param3, var1; -- 显示参数值
    
    open cursorVar; -- 打开光标
    
    repeat -- 循环
		fetch cursorVar into var2, var3, var4;
        if var4 = 2 then  -- 分支
			insert into r_resource_wrong(resource_id, wrong_id, type) values (var2, 3, var4);
        end if;
	until done=1
	end repeat;
    
    
    close cursorVar; -- 关闭光标	
end
$$ delimiter ;


-- 调用带参数的存储过程，输入输出参数都要写
call demo(@userVar1, @userVar2, @userVar3);
