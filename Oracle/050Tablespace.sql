/************************************************* Tablespace **********************************************/
select * from dba_data_files; -- 查看当前数据库所有表空间
select * from dba_temp_files; -- 查看当前数据库所有临时表空间
--Oracle Database: 是指一系列文档的集合（数据文件，日志文件，控制文件等），能对应多个 Instance，可创建多个 TableSpace

    -- Query
    select tablespace_name from dba_tablespaces;        -- 查询当前数据库下所有表空间
            -- 查询指定表空间的具体信息
    select table_name from dba_tables where tablespace_name='表空间名'; --查询当前表空间下所有表,注意 "表空间名" 必须大写
    select dbms_metadata.get_ddl('TABLESPACE','tablespaceName') from dual; -- 查看表空间的创建语句 ddl


    -- 创建数据表空间
    create tablespace tsKasei                               -- 创建名为 tsKasei 的表空间 
    logging  
    datafile '/home/oracle/oradata/ora11g/tsKasei.dbf'      -- 指定数据文件位置
    size 128m autoextend on next 64m maxsize 2048m          -- 指定表空间为 128M，自动扩容开启，每次扩容 64M，最大容量 2048M
    extent management local;                                -- 设置管理区间为： 本地管理
    
    -- 创建临时表空间
    create temporary tablespace tsKaseiTmp          
    tempfile '/home/oracle/oradata/ora11g/tsKaseiTmp.dbf'       
    size 128m autoextend on next 64m maxsize 2048m                          
    extent management local;                        

    
    -- 删除表空间，同时删除数据文件 
    alter tablespace tsKasei offline;  -- 先将表空间 offline
    drop tablespace tsKasei including contents and datafiles cascade constraint;


    -- 修改表空间
    alter database datafile '/home/oracle/oradata/ora11g/tsKasei.dbf' resize 1024m；
    alter database datafile '/home/oracle/oradata/ora11g/tsKasei.dbf' autoextend on next 128m maxsize 4096m;
