# head tail
shell> head -n 10      # 获取头 10 行
shell> head -n -10     # 丢弃最后 10 行
shell> tail -n 10      # 获取尾 10 行
shell> tail -n +10     # 丢弃开头 10 行


# find 
# 查找文件
shell> find 
shell> find 文件目录 -name ‘*.*' -exec grep 'xxx' {} + -n    # 查找多个文件中的匹配内容
shell> find 文件目录 -name '*.*' | xargs grep 'xxx' -n       # 查找多个文件中的匹配内容



# grep 
# 只显示包含指定 pattern 的行
# @trap
#   BRE 元字符: ?, +, {, |, (, )    需要使用  \?, \+, \{, \|, \(, \) 来表示
#   传统 egrep 中，不支持 { 作为 元字符，一些实现版本使用 \{ 表示 元字符，为了兼容性考虑， ERE 中应该避免使用 {，并且用 [{] 来表示字面量
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

shell> grep --binary-files=text 'pattern' file          # 当报 grep: /proc/77/cmdline: binary file matches 时，将二进制文件当作文本文件处理
shell> grep -a 'pattern' file                           # 同上
shell> grep --text 'pattern' file                       # 同上


shell> grep -P -i -v -n -H -C 2 -R pattern file         # 常用选项 
shell> grep -- 'pattern' file                           # 当 pattern 中包含 - 等选项相关的字符时


# xargs 
# 作用：将标准输入转换成命令的参数，默认拼接在命令的最后
#      xargs 命令会把输入的字符串中的 换行 和 其他空白字符 替换成空格
#      然后根据 定界符 将输入中的字符串分隔成一段段连续的字符串, 并将这些字符串当做 command 的 参数或选项 依次拼接到 command 后面
# 执行顺序: 转换 -> 分割 -> 分批 -> 传参
#       @trap 转换 只有在没有指定 分割符 时存在，即: shell> xargs
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
    -i              # 使用 {} 作为 占位符 标记，@deprecated
    --replace=[R]   # 使用 R 作为 占位符 标记，如果 R 没有指定，那么占位符默认为 {}
                    # 使用 -I -i --replace=R 等选项后, xargs 的默认 定界符 会变成 \n, 而不是 space, 
                    # 如果需要使用 space 需要额外指定 -d ' '
    

分割: 
shell> xargs                            # 把输入的字符串中的 换行 和 其他空白字符 替换成空格，以 空格 作为分割符
shell> xargs -d 'str'                   # 不处理输入字符串，指定 字符串 作为分割符
shell> xargs -0                         # 不处理输入字符串，等价于 shell> xargs -d '\0'     \0 == null

分批:
shell> xargs -n2                        # 把输入的字符串中的 换行 和 其他空白字符 替换成空格，以 ' ' 为分割符，分割后每次使用 2 个当作参数
shell> xargs -d"\n" -n2                 # 不处理输入字符串，以 \n 为分割符，分割后每次使用 2 个当作参数
shell> xargs -L2                        # 不处理输入字符串，以 \n 为分割符，分割后每次使用 2 个当作参数
shell> xargs -d' ' -L2                  # 不处理输入字符串，以 ' ' 为分割符，分割后每次使用 2 个当作参数
shell> xargs -I{}                       # 不处理输入字符串，等价于 shell> xargs -L1  然后使用占位符 {}
shell> xargs -I{} -L2                   # 不处理输入字符串，由于 -L2 在后面定义，所以直接覆盖 -I{}, 连着占位符的效果一并覆盖，所以占位符没用了

# 传参
# 默认直接拼接在 cmd 后面
# -I{} 模式，则用 单引号 包裹，传入占位符，如果 1 批里面包含多个 command-line 参数，则需要使用 bash -c 'cmd {}' 来执行
shell> echo '' | xargs -rtI{} bash -c 'cmd {}'      #  1 批里面包含多个 command-line 参数时，使用方法





shell> echo 1 2 3 | xargs -n 1 touch                        # 每行输出 1 个，然后将每行的字符串作为后面命令的参数
shell> echo ggXaaXhh | xargs -d X -n 1 echo                 # 修改定界符为 'X'
shell> echo kasei | xargs -I {} ./sk.sh -p {} -l            # -I 指定占位符为 {}， 命令行中的 {} 将被传入的参数所替代 
shell> echo aaa | xargs -rti ./sk.sh -p {} -l               # 最常用, @trap -i 必须是最后一个，-i 已经废弃，使用 -I{} 替代
shell> echo aaa | xargs -rtI{} ./sk.sh -p {} -l             # 最常用 
shell> echo aaa bbb | xargs -d ' ' -rtI{} ./sk.sh -p {} -l  # 最常用，指定分隔符

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
# 处理步骤:
#   1. 先读入一行，去掉尾部换行符，把当前处理的行存储在临时缓冲区中，称为“模式空间”（pattern space），执行编辑命令
#   2. 处理完毕，除非加了 -n 参数，把现在的 pattern space 打印出来，在后边打印曾去掉的换行符
#   3. 把 pattern space 内容给 hold space，把 pattern space 置空。
#   4. 接着读下一行，处理下一行。
#
# @help: http://www.gnu.org/software/sed/manual/html_node/index.html
# @trap sed 默认正则为 BRE，使用 -r 可以改为 ERE，但是无法使用 PCRE
#
# Format := sed -e [addr]X[options] -e [addr]X[options] (file | -)
# 
# addr := [         
#   number | $ | first~step | /regexp/ | \%regexp% | /regexp/I | /regexp/M              # SingleAddr 单地址
#   | number,number | 0,/regexp/ | SingleAddr,+number | SingleAddr,~number | SingleAddr,+number { SingleAddr }              # 范围地址
# ]!        # 如果存在 ! 后缀，则表示 addr 是 否定的，即: 非(not)
# 
# X := cmd
#   @trap   X                   都是单字母的
#   @trap   {,},b,t,T,:         命令可以被 semicolon 分隔
#   @trap   a,c,i               命令不能用 simicolons(;) 作为命令分隔符，必须使用 \n(newline) 或者将命令放在脚本最后
#   @trap   r,R,w,W             命令认为 到 newline 字符之前的所有字符全是 filename
# 
#   a text              # 在当前行后 追加一行 text
#   b label             # 无条件分支（即：始终跳转到标签，跳过或重复其他命令，而不重新启动新循环）。与地址结合，可以在匹配的行上有条件地执行分支       
#   c text              # 整行 替换为 text
#   d                   # 删除
#   D                   # 删除直到第一个 换行符
#   e                   # 执行 pattern 匹配出来的 command，然后用命令结果替换 pattern 匹配的 text
#   e command           # 执行 command 并将结果输出
#   F                   # 在当前行后 打印一行文件名
#   g                   # 使用 hold space 替换 pattern space
#   G                   # 先往 pattern space 添加 newline，然后追加 hold space 到 pattern space  
#   h                   # 使用 pattern space 替换 hold space
#   H                   # 先往 hold space 添加 newline，然后追加 pattern space 到 hold space  
#   i text              # 在当前行前 插入一行 text
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
#   t label             # 仅当自读取最后一个输入行或采取另一个条件分支以来 s/// 命令成功时，才有条件分支（即：跳转到标签）
#   T label             # 与 t 命令类似但相反：仅当自上次读取输入行以来没有成功替换时才分支
#   v [version]
#   w filename          # 将 pattern space 写入文件
#   W filename          # 将 pattern space 直到 \n  写入文件
#   x                   # 交换 pattern space 和 hold space
#   y/src/dst/          # 将 pattern space 中 src 中的 "单个字符"，替换为 dst 中的。@trap 注意不是 字符串
#   z                   # zap: 清空 pattern space
#   #                   # 注释 直到 \n
#   { cmd ; cmd ... }   # 
#   =                   # 在行尾打印行号
#   : label             # 为分支命令(b,t,T) 指定 label 的位置
#   [addr]X             # 分支条件，if[addr] 和当前 pattern space 匹配，则执行 X
#   [addr]{ X ; X ; X } # 同上，分支条件，执行多个 X

# OPTIONS :=
shell> sed -r -n -e 'addrXoptions' -        # -r 使用扩展正则(egrep); -n 只输出执行过 sed 的行; -e 匹配脚本; -n 不自动打印读入的数据; - 表示文件从 stdin 读取
shell> sed -i 'X' filename                  # -i 直接用修改后的内容，覆盖原文件
shell> sed -r -n -e 'addr{X;X}options' -       # {X;X} 同时执行多命令 
shell> sed 's/regex/replacement/' file1        # 替换每一行首次匹配的文本
shell> sed 's/regex/replacement/g' file1        # 全局替换匹配的文本
shell> seq 3 | sed ':a;N;$!ba;s/\n/:/g'        # 结果为 = 1:2:3   $!ba = 不是最后一行则跳回 a 执行

shell> seq 6 | sed -e 1d -e 3d -e 5d            # 多 cmd 模式
shell> seq 6 | sed '1d;3d;5d'
shell> echo -n '  1234 567  ' | sed -r -e 's/^\s*(\S(.*)\S)\s*$/\1/'        # 巨神坑: ERE [] 中 \ 作为普通字符




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



