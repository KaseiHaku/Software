# head tail
shell> head -n 10      # 获取头 10 行
shell> head -n -10     # 丢弃最后 10 行
shell> tail -n 10      # 获取尾 10 行
shell> tail -n -10     # 丢弃开头 10 行


# find 
# 查找文件
shell> find 
shell> find 文件目录 -name ‘*.*' -exec grep 'xxx' {} + -n    # 查找多个文件中的匹配内容
shell> find 文件目录 -name '*.*' | xargs grep 'xxx' -n       # 查找多个文件中的匹配内容



# grep 
# 只显示包含指定 pattern 的行
shell> grep -P pattern file1 file2                      # 表示 pattern 是一个正则表达式
shell> grep -i pattern file1 file2                      # 忽略大小写
shell> grep -v pattern  file                            # 反选
shell> grep -n pattern file1 file2                      # 输出匹配串在文件中的行号
shell> grep -H pattern  file                            # 打印文件名
shell> grep -C 2 pattern file                           # 打印 2 行上下文
shell> grep -R pattern file1 file2                      # 递归搜索子目录，包括所有 symlinks

shell> grep --color=auto pattern file1 file2            # 匹配字符串高亮显示
shell> grep -f fileRegexp file1 file2                   # 从文件中读取 pattern ，文件中一行为一个 pattern， 命令匹配所有文件中的 pattern
shell> grep 'XXX' `find /path -name '*.*'               # 查找多个文件中的匹配内容

shell> grep -P -i -v -n -H -C 2 -R pattern file         # 常用选项 


# xargs 
# 作用：将标准输入转换成命令的参数，默认拼接在命令的最后
#      xargs 命令会把输入的字符串中的 换行 和 其他空白字符 替换成空格
#      然后根据 定界符 将输入中的字符串分隔成一段段连续的字符串, 并将这些字符串当做 command 的 参数或选项 依次拼接到 command 后面
# 定界符：默认定界符是 空格，       
shell> xargs [option] command [command-option]
    -a file         # 从指定文件读入输入，而不是标准输入中
    -p              # 交互执行
    -r              # 如果参数为空，则不执行命令，不加至少执行一次命令
    -t              # 执行命令前，先打印命令
    -E END          # 如果碰到内容为 END 的一行，那么后续内容不再解析
    
    # 分割命令
    # 无参数         # 
    -d ,            # 修改分隔符为 ',' quote(引号) 和 backslash 在此处无特殊含义
    -0              # 表示分隔符为 null, 同 --null 选项
    
    
    # 分批命令
    -L 1            # 一个 xarg 命令最多使用输入中的多少个非空行
    -n 1            # 一次命令使用多少个分隔出来的 字符串, 当做命令的参数
    
    # 参数传递
    -I R            # 等同 --replace=R， R 必须指定 
    -i              # 使用 {} 作为 占位符 标记
    --replace=[R]   # 使用 R 作为 占位符 标记，如果 R 没有指定，那么占位符默认为 {}
                    # 使用 -I -i --replace=R 等选项后, xargs 的默认 定界符 会变成 \n, 而不是 space, 
                    # 如果需要使用 space 需要额外指定 -d ' '
    
    
shell> echo 1 2 3 | xargs -n 1 touch                       # 每行输出 1 个，然后将每行的字符串作为后面命令的参数
shell> echo ggXaaXhh | xargs -d X -n 1 echo                # 修改定界符为 'X'
shell> echo kasei | xargs -I {} ./sk.sh -p {} -l           # -I 指定占位符为 {}， 命令行中的 {} 将被传入的参数所替代 
shell> echo aaa | xargs -rti ./sk.sh -p {} -l               # 最常用, @trap -i 必须是最后一个

# xargs Demo
# 假设输入的字符串为 A：  '1 2\t3\n4\\5'
# 不要相信 Console 的输出格式，查看处理前的内容必须使用 cat 命令
# 注意：在 xargs 中 转换前的 A 和 转换后的 A' 是同时存在的，不同的命令会选取不同的串进行操作
shell> echo '1 2\t3\n4\\5' | cat        

# 使用 xargs 转换
# 将所有 空格 制表符 换行符 都替换成 空格，单双引号 反斜杠 会被 xargs 去除
# 转换后 A1： '1 2 3 45'    
shell> echo '' | cat | xargs       

# 使用 xargs -d 转换
# 转换后 A2： '1 2\t3\n' '\\5'
shell> echo '' | cat | xargs -d4   

# 使用 xargs -0 转换，等价于 xargs -d'\0'
# 转换后 A3：
shell> echo '' | cat | xargs -0




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






# cut
# 按列切分文本
shell> cut -d ';'   # 指定分割符
shell> cut -f 1-2   # 输出 第1列 到 第2列

# paste
# 按列拼接文本
shell> paste file1 file2  # 将 file1 file2 按列合并

# split
# 分割文件
shell> split 


# wc
# 行及字符统计工具

# tr
# translate，squeeze，delete 单字符工具
shell> echo 12345 | tr '2' 'q'        # 将 2 替换成 q
shell> echo 12345 | tr -c '2' 'q'     # 逆向匹配，将 非2 替换成 q
shell> echo 12345 | tr -d '2'         # 删除 字符2
shell> echo 12225 | tr -s '2'         # 压缩重复字符2

# sed 
# 每次读入一行，对该行进行 文本替换 和 搜索
# @help: http://www.gnu.org/software/sed/manual/html_node/index.html
# Format := sed -e [addr]X[options] -e [addr]X[options] (file | -)
# addr := [ 
#   number | $ | first~step | /regexp/ | \%regexp% | /regexp/I | /regexp/M              # SingleAddr 单地址
#   | number,number | 0,/regexp/ | SingleAddr,+number | SingleAddr,~number | SingleAddr,+number { SingleAddr }              # 范围地址
# ]
# X := cmd
#   @trap   {,},b,t,T,:         命令可以被 semicolon 分隔
#   @trap   a,c,i               命令可以被 newline 分隔
#   @trap   r,R,w,W             命令认为 到 newline 字符之前的所有字符全是 filename
# 
#   a text              # 行尾 追加 text
#   b label             #          
#   c text              # 整行 替换为 text
#   d                   # 删除
#   D                   # 删除直到第一个 换行符
#   e                   # 执行 pattern 匹配出来的 command，然后用命令结果替换 pattern 匹配的 text
#   e command           # 执行 command 并将结果输出
#   F                   # 在行尾打印文件名
#   g                   # 使用 hold space 替换 pattern space
#   G                   # 先往 pattern space 添加 newline，然后追加 hold space 到 pattern space  
#   h                   # 使用 pattern space 替换 hold space
#   H                   # 先往 hold space 添加 newline，然后追加 pattern space 到 hold space  
#   i text              # 在当前 line 之前插入文本。支持 newline 分隔 cmd
#   l                   # 清晰的打印 pattern space 
#   n                   # 如果 auto-print 没有关闭，使用下一行输入，替换当前行的 pattern space
#   N                   # pattern space 追加 \n, 然后 追加下一行输入到当前 pattern space
#   p                   # 打印 pattern space
#   P                   # 打印 pattern space 直到 \n
#   q[exit-code]        # 退出 sed
#   Q[exit-code]        # 同上，但是不打印 pattern space
#   r filename          # 读取文件
#   R filename          # 读取文件，并插入到输出
#   s/regexp/replacement/[flags]    # 替换， replacement 中 &=regexp 匹配的部分; \1-\9=捕获组
#   t label             # 
#   v [version]
#   w filename          # 将 pattern space 写入文件
#   W filename          # 将 pattern space 直到 \n  写入文件
#   x                   # 交换 pattern space 和 hold space
#   y/src/dst/          # 将 pattern space 中 src 中的字符，替换为 dst 中的
#   z                   # zap: 清空 pattern space
#   #                   # 注释 直到 \n
#   { cmd ; cmd ... }   # 
#   =                   # 在行尾打印行号
#   : label             # 为分支命令(b,t,T) 指定 label 的位置
# OPTIONS :=
shell> sed -r -n -e 'addrXoptions' -        # -r 使用扩展正则(egrep); -n 只输出执行过 sed 的行; -e 匹配脚本; -n 不自动打印读入的数据; - 表示文件从 stdin 读取
shell> sed -r -n -e 'addr{X;X}options' -       # {X;X} 同时执行多命令 
shell> sed 's/regex/replacement/' file1        # 替换每一行首次匹配的文本
shell> sed 's/regex/replacement/g' file1        # 全局替换匹配的文本

shell> seq 6 | sed -e 1d -e 3d -e 5d            # 多 cmd 模式
shell> seq 6 | sed '1d;3d;5d'



# awk
# 处理规则：
#   1. 每次读取一个符合 pattern 的 record； record 分隔符见下
#   2. 将 record 分隔成若干个 field         # 分隔符 默认为 Space 或 Tab
#   3. 对 field 进行细节处理
shell> awk option -f program -- file1 file2
shell> awk option -- 'program' file1 file2
shell> awk option -- 'pattern {action statement}' file
shell> echo -e 'aa bb cc\nyy xx zz' | awk -F ' ' -e '{print $1}'        # $0 表示当前行，$1 表示当前行分割后的第 1 个 field

# expr
# 表达式
shell> expr     # 字符串截取


# printf echo column
# 格式化输出
# printf Format:   %[flags][width][.precision][length]specifier
#       specifier: c, s;    d, i, f, u;     o, x, X;    e, E, g, G;     p, n;   %; 
#       flag: -, +, space, #, 0
#       width: number, *
#       precision: .number, .*
#       length: h, l, L
shell> printf "八进制整数 %o, 十进制整数 %d, 十进制浮点数 %f, 十六进制整数 %x, 科学计数 %e, 字符串 %s, 字符 %c, %%\n" 010 10 10.1 0xff 100 str c 
shell> echo -e 'as\ndsa' 
shell> column -t -s 'delimiter' file        # 格式化为列，-s 指定分隔符

# hexdump
# 字符串转 十六进制
shell> hexdump

# xxd

# dd


