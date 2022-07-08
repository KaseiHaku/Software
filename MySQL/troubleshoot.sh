慢查询排查：{
    mysql> show variables like '%slow_query%';          # 查看 慢查询日志 是否开启，及 慢查询日志 文件存放位置
    mysql> show variables like '%long_query_time%';     # 设置超过多少时间就算 慢查询，单位: 秒
    mysql> show variables like '%log_output%';          # 指定日志输出到哪里
   
    # 慢查询文件过滤
    shell> head -n 1000 tzxb-db-01-slow.log |cat -n  |  sed -rne '/^[[:digit:][:space:]]+# Query_time/{p}' | awk -- '$3>20 {print $0}'
    
}
