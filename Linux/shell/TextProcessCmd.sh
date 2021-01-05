# find 
# 查找文件
shell> find 


# grep 
# 只显示包含指定 pattern 的行
shell> grep -i pattern file1 file2                     # 忽略大小写
shell> grep -n pattern file1 file2                     # 输出匹配串在文件中的行号
shell> grep -r pattern file1 file2                     # 递归搜索子目录
shell> grep --color=auto pattern file1 file2           # 匹配字符串高亮显示
shell> grep -E pattern file1 file2                     # 表示 pattern 是一个正则表达式
shell> grep -f fileRegexp file1 file2                  # 从文件中读取 pattern ，文件中一行为一个 pattern， 命令匹配所有文件中的 pattern
shell> grep -v 反选


# xargs 
# 作用： 将标准输入转换成命令的参数，默认拼接在命令的最后
# 定界符： 默认定界符是 空格， xargs 命令会把输入的字符串中的 换行 和 其他空白字符 替换成空格
shell> xargs [option] command [command-option]
    -a file         # 从指定文件读入输入，而不是标准输入中
    -d ,            # 修改分隔符
    -i              # 使用 {} 作为占位符标记，可以使用 --replace=[R] 替换默认的占位符 {}
    -n 1            # 一次命令使用多少个分隔符
    -l 1            # 一个 xarg 命令最多使用输入中的多少个非空行
    
shell> echo 1 2 3 | xargs -n 1 touch                       # 每行输出 1 个，然后将每行的字符串作为后面命令的参数
shell> echo ggXaaXhh | xargs -d X -n 1 echo                # 修改定界符为 'X'
shell> echo kasei | xargs -I {} ./sk.sh -p {} -l           # -I 指定占位符为 {}， 命令行中的 {} 将被传入的参数所替代 

# sort
# 排序
shell> sort -n          # 按数字序排序
shell> sort -d          # 按字典序排序
shell> sort -r          # 逆序
shell> sort -k 1        # 按第 1 列 排序
shell> sort -bd         # 忽略像空格之类的前导空白字符


# uniq
# 消除重复行
shell> sort unsort.txt | uniq         # 消除重复行
shell> sort unsort.txt | uniq -c      # 统计各行在文件中出现的次数
shell> sort unsort.txt | uniq -d      # 找出重复行


# tr
# translate，squeeze，delete 字符串
shell> echo 12345 | tr '2' 'q'        # 将 2 替换成 q
shell> echo 12345 | tr -c '2' 'q'     # 逆向匹配，将 非2 替换成 q
shell> echo 12345 | tr -d '2'         # 删除 字符2
shell> echo 12225 | tr -s '2'         # 压缩重复字符2



# cut
# 按列切分文本
shell> cut -d ';'   # 指定分割符
shell> cut -f 1-2   # 输出 第1列 到 第2列

# paste
# 按列拼接文本
shell> paste file1 file2  # 将 file1 file2 按列合并


# wc
# 行及字符统计工具

# sed 
# 文本替换工具
shell> sed      # 类似 vim 的替换，但是不需要打开文件



# awk
# 数据流工具

# expr
# 表达式
shell> expr     # 字符串截取

