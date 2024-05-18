# awk
# 处理规则：
#   1. 每次读取一个符合 pattern 的 record； record 分隔符见下
#   2. 将 record 分隔成若干个 field         # 分隔符 默认为 Space 或 Tab
#   3. 对 field 进行细节处理

shell> gawk option -f program -- file1 file2
shell> gawk option -- 'program' file1 file2
           -f progFile      --file=progFile         # 代码文件，可以多次，awk 将按序合并文件中的 program
           -F [:][,]        --field-separator=[:][,]     # 字段分隔符列表，以 : ] [ , 四个作为分隔符
           -v var=val       --assign=var=val               # 定义变量
           -b               --characters-as-bytes       
           -c               --traditional               # 传统模式，progFile 为目录时报错，否则弹警告
           -C               --copyright
           -d file          --dump-variables[=file]
           -e 'programText' --source='programText'      #  可以多次，awk 将按序合并文件
           -E file           --exec=file
           -g               --gen-pot
           -h               --help           # 帮助
           -L fatal         --lint[=fatal]
           -n               --non-decimal-data
           -N               --use-lc-numeric
           -O               --optimize
           -p file          --profile[=file]
           -P               --posix                 # 符合 POSIX 标准，progFile 为目录时报错，否则弹警告
           -r               --re-interval
           -S               --sandbox              # 沙盒
           -t               --lint-old
           -V               --version             # 版本


program:
    @include "file" pattern {action statements}
    function name(parameter list){statements}
    
    执行顺序:
        执行命令行中定义的变量 shell> awk -v var1=val1 -v var2=val2    
        执行 BEGIN {} 中的语句，会合并所有文件中的 BEGIN
        读取 ARGV 数组中的每个文件，直到 ARGV[ARGC]；如果没有，那么从 stdin 中读取
        如果命令行中 filename 的格式为： var=val，那么会被当做变量赋值
        执行一个文件中的 BEGINFILE 语句块
        执行一个文件中的语句
        执行一个文件中的 ENDFILE 语句块
        执行 END {} 中的语句，会合并所有文件中的 END
    

Variable: 变量
    第一次使用之后才存在，
    可以为 浮点数，字符串，一维数组，模拟的多维数组
    
    内建变量：
        ARGC                # 命令行参数数量，不包含 options 和 program source
        ARGIND              # 当前正在执行的 file，所在的 ARGV 的 index
        ARGV                # 命令行参数数组， index = 0 ~ ARGC-1，
        BINMODE
        CONVFMT             # 数字转字符串格式，默认: "%.6g"
        ENVIRON
        ERRNO
        FIELDWIDTHS         # 不使用 FS 进行 record 分割，而是根据该变量指定的 宽度 来分割，
                            # 例如: FIELDWIDTHS="2 4 8" 表示第一个 field 有 2 个字符，第二个 field 有 4 个字符，... 
        FILENAME
        FNR                 # 读取时，当前 record 的序号
        FPAT                # 不使用 FS 进行 record 分割，而是根据该变量指定的 regexp 来分割 field
        FS                  # 读取时，field 的分割符，默认 space
        IGNORECASE
        LINT
        NF                  # 当前 recored 分隔出了多少个 field
        NR                  # 行号
        OFMT
        OFS                 # 输出时，field 的分隔符，默认空格
        ORS                 # 输出时，record 的结束符，输出的字符
        PROCINFO
        RS                  # 读取时，record 的分隔符，默认 \n
        RT                  # 读取时，record 的结束符
        RSTART
        RLENGTH
        SUBSEP              # 一个数组元素，有多个 subscripts(下标)时，各个 subscripts 的分隔符，默认 '\034'
        TEXTDOMAIN


Records: 记录
    正常情况下，一条 record 就是一行，使用 \n 分隔。给内建变量 RS 赋值，可以改变 record 的分隔符
    RS 
        如果是单字符，那么就是分隔符；
        如果是字符串，那么被认为是一个 regexp（不区分大小写），在兼容模式下，以正则表达式匹配项的第一个字符为分隔符
        如果是 null，则以 空行 为分隔符

Field: 字段
    FS
        如果是单字符，那么就是分隔符；
        如果是 null, 那么将所有字符都当做一个 field
        如果是 字符串，那么当做是 regexp（不区分大小写）
        如果是 单个空格，那么分隔符为: spaces, tabs, newlines
    FIELDWIDTHS
        当设置值时，将按固定长度分隔 field，FS 将被忽略，重新设置 FS 或者 FPAT 会覆盖 FIELDWIDTHS 的使用
    FPAT
        当设置 regexp 时，Field 将由所有匹配 regexp 的字符串组成，regexp 不是作为分隔，而是作为 field 自身
    
    $1, $2, ..., $n; $n 中的 n 可以由变量替换，例如: $var 也是有效的；对 $n 赋值，会重建 $0 的引用
    $0 表示整个 record，对 $0 赋值，会重新 resplit

    NF 变量保存当前 record 总共有多少个 field，使用 $(NF+2) = 5 给不存在的 field 赋值，会导致 NF 增加，介于中间的值都为 null
    
Array & Map:
    ary[subscript]                  # subscript 可以是 字符串 ，所以 awk 的 array 可以当作 map 用，类似 JS 的设计
    ary[(exp1, exp2, exp3)]         # 实际下标 = exp1 $SUBSEP exp2 $SUBSEP exp3,  这种 facility(方式) 可以很方便的模拟多维数组
    
    if(val in array)                # 遍历 ary/map 的 subscript/key
        print arrays[val]
        delete array[2]
        delte array[]       # 删除所有元素

Variable Typing And Conversion
    num16 = 0x11            # 16 进制数字，17
    num8 = 011              # 8 进制数字，9
    num = 23.23 + 0            # 强制将一个变量作为数字对待
    str = var ""        # 强制将一个变量当做字符串对待

    awk 使用 strtod 来实现将 str 转成 number
    awk 使用 CONVFMT 内建变量所指定的格式，使用 sprintf 来将 number 转换成 str, 尽管 awk 中所有的数字都是浮点数，但是完整的浮点数总是被转换成 整数 类型的字符串，而不会带小数点

    awk 两个值比较时，
        两个值都为 数字：数字 比较
        一个值为数字，一个值为 数字字符串：数字 比较
        其他: 字符串比较
    
    str = "\\"      # \
    str = "\t"      # tab
    str = "\r"      # carriage return
    str = "\n"      # newline
    str = "\xHex"      # 16 进制数字
    str = "\ddd"      # 8 进制数字
    str = "\c"      # c

Expression:
    expr in array
    (index) in array
    
    expr1 ? expr2 : expr3
    
    expr1 >= expr2

    expr1 = expr2        # 赋值
    expr1 += expr2       # 同 java  +=

    expr1 && expr2        # 逻辑运算

    $expr                # Field 引用

    str ~ /regex/        # str 匹配 regex，return 1; else return 0;
    str !~ /regex/       # str 匹配 regex，return 0; else return 1;

PATTERNS：
    格式：pattern {action}
        如果 pattern 缺失，则 action 针对每个 record 都会执行
        如果 action 缺失，则相当于 action 就是 {print}

    注释: 以 # 开始，以 \n 结束。
    语句以 \n 结束，除非语句最后的字符为 ',' '{' '?' ':' '&&' '||';  do 和 else 语句中的 statement 也不以 \n 结束
    其中 \ 结尾行，表示续行

    PATTERN:
        BEGIN
        END
        BEGINFILE
        ENDFILE
        /regular expression/                # 正则表达式，符合 egrep 标准
        relational expression               # 用于测试指定的 field 是否符合 regexp
        
        pattern && pattern
        pattern || pattern
        pattern1 ? pattern2 : pattern2      # 如果 pattern1 匹配，则执行 pattern2 进行匹配，否则执行 pattern3 
        (pattern)                           # 
        ! pattern                           # 匹配 不符合 pattern 的 record
        pattern1, pattern2                  # 范围模式，从匹配 pattern1 的 record 开始，到匹配 pattern2 的 record 结束

    常见格式:
        BEGIN {} pattern1,pattern2 {} END {}

ACTIONS: 
    由多个 Statement 组成，Statement 之间使用 \n 或者 ; 分隔
    
    OPERATOR: 优先级从高到低
        (...)
        $
        ++, --
        ^, **                           # 幂
        +, -, !
        *, /, %
        +, - 
        space           
        |, |&
        <, >, <=, >=, !=, ==
        ~, !~
        in 
        &&
        ||
        ?:
        =, +=, -=, *=, /=, %=, ^=, **=
    Control Statement: 流程控制
        if (condition) statement [ else statement ]
        while (condition) statement
        do statement while (condition)
        for (expr1; expr2; expr3) statement
        for (var in array) statement
        break
        continue
        delete array[index]
        delete array
        exit [ expression ]
        { statements }
        switch (expression) {
            case value|regex : statement
            ...
            [ default: statement ]
        }
    I/O Statements:
        close(file [, how])
        getline
        getline <file
        getline var
        getline var <file
        command | getline [var]
        command |& getline [var]
        next
        nextfile
        print
        print expr-list
        print expr-list >file
        printf fmt, expr-list
        printf fmt, expr-list >file
        system(cmd-line)
        fflush([file])
        print ... >> file
        print ... | command
        print ... |& command
        
    Functions:
        在 action 中的函数，包含: Numeric, String, Time, Bit Manipulations
        
Examples:
    shell> gawk -F [,;] -v var=val -- 'program' file1 file2
    shell> gawk -F [,;] -v var=val -e 'program' -- file1 file2
    
    
    shell> cat <<EOF | tee script.awk && cat bb.txt | gawk -f script.awk -- -        # 先编写 script.awk 脚本，再对 awk 的标准输入执行该脚本
    {print \$2}             # 这里必须对 shell 中的 特殊字符做转义
    EOF
    
    shell> cat <<EOF | gawk -f '-' -- bb.txt             # 将 标准输入 作为 awk 的脚本文件，对 bb.txt 执行脚本
    {print \$2}             # 这里必须对 shell 中的 特殊字符做转义
    EOF
    
    shell> cat <<'EOF' | gawk -f - -- bb.txt             # 将 标准输入 作为 awk 的脚本文件，对 bb.txt 执行脚本
    {print $2}              # 因为 EOF 被 引号 包含，所以这里的字符不会被  shell 特殊对待
    EOF
    
    shell> gawk -- 'BEGIN {FIELDWIDTHS="1 10 117 32"} { print $4} END {}' dd.txt
    
    
    shell> ss | awk -- '/^tcp/ {map[$2]++} END { for(key in map){ print key, map[key]} } '        # 统计重复行的数量，awk map 和 ary 语法相同
