/* *********************** Oracle 常见错误及解决办法 *************************************/
/* * ERROR：ORA-12899 */
[oracle@KSF]$ sqlplus /nolog
SQL> conn / as sysdba;
SQL>shutdown immediate;
SQL>startup mount;
SQL>alter system enable restricted session;
SQL>alter system set job_queue_processes=0;
SQL>alter system set aq_tm_processes=0;
SQL>alter database open;

SQL>alter database character set zhs16gbk;
alter database character set zhs16gbk
*error at line 1:
ora-12712: new character set must be a superset of old character set	--报字符集不兼容，此时下internal_use指令不对字符集超集进行检查：

SQL>alter database character set internal_use zhs16gbk;
SQL>shutdown immediate;
SQL>startup;


/* linux 环境oracle sqlplus下使用退格backspace回删出现^H的解决办法*/
-- 1.进入sqlplus前设置回删 
[oracle@ksf]$ stty erase '^H'   -- stty 修改终端参数

-- 2.修改环境变量 .profile 
在当前用户的.profile里面加入这个命令。这个命令的意思就是使用 BackSpace 键作为删除键

-- 3.直接在sqlplus里面用ctrl+backspace代替backspace即可