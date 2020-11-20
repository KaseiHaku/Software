/** Mysql 变量 
 *  变量主要有以下几种类型：local, user, session, global
 *
 * 
 */
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
