/** todo Oracle Database Context Parameters: Oracle 数据库上下文环境参数 */
SQL> select * from v$parameter;         -- 查看所有参数
SQL> alter system set paramName=value COMMENT '' deferred SCOPE={ MEMORY | SPFILE | BOTH } SID={'sid'|*};  -- 修改参数
SQL> alter session set current_schema=BPM_ISSUE;        -- 修改当前 session 默认 Schema 为 BPM_ISSUE 这个 Schema(用户)
SQL> select SYS_CONTEXT('USERENV','CURRENT_SCHEMA') CURRENT_SCHEMA from dual; -- 查看当前使用的 Schema
