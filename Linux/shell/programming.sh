#!/bin/bash -e           "#!" 是一个约定的标记，它告诉系统这个脚本需要什么解释器来执行，即使用哪一种Shell。

# 帮助
help
help funcName
info bash
man -k command
info command



# set 命令
#   shell> set [--abefhkmnptuvxBCEHPT] [-o option-name] [arg ...]       # 格式
#   shell> set                  # 不带任何 option，列出当前所有变量
#   shell> set -u               # 当带了 option 时，表示修改当前 shell 的配置
#   shell> set -u aa bb cc      # option 后面的参数都被当做 position params 的值，即: $1, $2, $3, ..., $n
#   shell> set -u -- aa -b -c   # -- 的作用是：表示所有 option 已经结束，后面尽管是 -b 也被当做 position params 处理
#   shell> set -u - aa -b -c    # - 的作用是: 同上
# 
# shell 配置:
#   shell> set [+-abCdefhHklmnpPtuvx]           # -e 表示开启 shell e 功能, +e 表示关闭 shell e 功能
#   shell> set -e                               # 若指令传回值不等于0，则立即退出shell。
#   shell> set -u 　                            # 当执行时使用到未定义过的变量，则显示错误信息。
#   shell> set -x                               # 用来在运行结果之前，先输出执行的那一行命令
set -- cmd "$@"             # 相当于 $@ = cmd "$@"


# 各种 bracket
# ()
(cmd1;cmd2;cmd3)            # 重新开一个子 shell 执行 () 中的命令, () 里面的重定向命令只影响 () 内的, 而 () 外的重定向影响 () 里的所有命令
$(cmd)              # 等价于 `cmd`, 执行 cmd 命令的输出，`cmd` 兼容性更好
ary=(1 2 3)         # 数组初始化

# (())
((exp))             # 等价于 let 命令, 如果 exp 结果为 0 , 那么返回退出码状态码为 1 (false); 如果 exp 结果非 0 , 那么返回退出状态码为 0 (true)
$((C Syntax))       # 等价于 let 命令, 只是提取计算结果出来使用, 只要括号中的内容符合 C 语言语法, 那么就可以执行, 比如: 
((a++))             # 给 $a +1
for((i=0;i<5;i++))  # 只要 (()) 中的语法符合 C 语言语法即可, (()) 中的变量可以不用 $ 带头


# []: 首尾必须带空格
$[]                 # $(()) 的过去形式, @Deprecate
if [...]            # 等价于 if test ...

# [[]]: 首尾必须带空格
[[]]                # 在 [[]] 中的所有的字符都不会发生文件名扩展或者单词分割，但是会发生参数扩展和命令替换



# {}
${var}                      # 表示引用变量的值
{1..30}                     # 表示 1-30
{a,b}tt                     # 表示 att 或者 btt
{ var=notest; echo $var;}   # 在当前 shell 中执行 {} 内部的命令, {} 里面的重定向命令只影响 {} 内的, 而 {} 外的重定向影响 {} 里的所有命令
                            # 坑: 第一个 { 后面必须跟一个 空格, 
                            # 坑: 最后一个命令需要用 ; 结尾
                          



# 1. 执行一个 shell 脚本
    # 方式一： 作为可执行程序
    chmod 744 ./test.sh         # 使脚本具有执行权限
    ./test.sh                   # 执行脚本;注意，一定要写成./test.sh，而不是 test.sh，运行其它二进制的程序也一样，
                                # 直接写test.sh，linux系统会去PATH里寻找有没有叫test.sh的，
                                          # 而只有/bin, /sbin, /usr/bin，/usr/sbin等在PATH里，你的当前目录通常不在PATH里，
                                # 所以写成test.sh是会找不到命令的，要用./test.sh告诉系统说，就在当前目录找。
    # 方法二： 作为解释器参数
    /bin/sh test.sh             # 其中 /bin/sh 是一个解释器
    

# 2. 文件包含 include
    . filename.sh                     # 方法1：注意点号(.)和文件名中间有一空格
    source filename.sh              # 方法2：

# 字符串
# "" 中可以使用的特殊字符有, \ ` $ 三个, 其他字符原样输出
# '' 中 不能出现 ' , 其他所有字符原样输出
# \  紧接 escape 之后的单一 特殊字符 被关闭
# 注意这仅仅是 shell 的处理, 跟命令里面的处理不相关
   

# 3. 变量： Shell 变量中的只有字符串类型，没有其他类型
    # Variable
    var="Kasei"                                     # 定义变量，变量名和等号之间不能有空格
    readonly var                                    # 将变量 var 设置为只读
    unset var                                       # 删除变量
    var="Haku"                                      # 修改变量的值
    echo ${var}                                     # 使用：变量使用时左值不用加$,右值才需要加${}
    
    
    # Array
    array=("kasei" "value2" "value3")               # 定义数组
    array[3]="haku"                                 # 为数组指定下标赋值
    echo ${array[2]}                                # 读取数组指定位置的值
    echo ${array[@]}                                # 读取数组中所有的值

    length=${#array[@]}                             # 取得数组元素的个数
    length=${#array[*]}                             # 取得数组元素的个数
    lengthn=${#array[3]}                            # 取得数组第4个元素的长度


    # 变量赋值
    cmdResult=`cmd`                   # 将 cmd 的结果赋值给变量 cmdResult

    # 注意： 如果变量没有用 export 声明，那这个变量只是 脚本变量，而不是 环境变量


# 4. 流程控制
# 具体查看 shell> help test
    # if(){}
    if commands;
    then 
        echo "w"
        echo "d";
    fi
    
    # if(){} else {}
    if commands; 
    then
        command1;
    else
        commandN;
    fi

    # if(){} else if(){} else{}
    if condition1 ;
    then
        command1;
    elif condition2 ;
    then 
        command2;
    else
        commandN;
    fi
    
    # case
    case $var in
        1)
            command1
            command2
            ...
            commandN
            ;;
        2)
            command1
            command2
            ...
            commandN
            continue    #跳过此次循环，跟C用法一样
            ;;
        *) #默认模式
            command1
            break        #跳出所有循环不是一层
            ;;
    esac
    
    # while
    while command; 
    do
        command
        break           #跳出所有循环不是一层
        continue        #跳过此次循环，跟C用法一样
        ;
    done
    
    # do while
    until condition ;
    do
        command;
    done
    
    # for
    for var in 1 2 3 ;                  # 依次将 1 2 3 按序赋值给 var，然后执行 do，直到 123 迭代完成
    do
        echo "value = ${var}"
        ;
    done
    
    for (( exp1; exp2; exp3 )) ;
    do command ;
    done

    #结果
    value = 1
    value = 2
    value = 3


# 5. 函数
    function funname(){ #shell 函数不带任何参数
        echo "${1}" # 调用函数第1个参数
        return int; # 参数返回，可以显示加：return 返回，如果不加，将以最后一条命令运行结果，作为返回值。 return 后跟数值n(0-255
    }
    funname we # 调用函数,we是函数的参数
    val=$? # 函数返回值在调用该函数后通过 $? 来获得
    


















!                   # Event Designators, !后面跟随的字母不是“空格、换行、回车、=和(”时，做命令替换,例如：!n, !-n, !string, !?string? 都是在 history 中匹配命令
~                    #当前用户home目录
.                    #当前目录
..                    #当前目录的父目录
:                    #bash内建指令："什么事都不干"，但返回状态值 0。
\                    #使转义字符失效
/                    #表示目录
cd -                #回到上一个工作目录


?                    #匹配任意一个字符，但不匹配 null 字符
*                    #匹配任意个数的字符
\<                    #匹配单词开始
\>                    #匹配单词结束
\b                    #匹配单词开始和结束两个都行
[abc]                #匹配a、b、c中的任何一个
[!abc]                #不匹配a、b、c中的任何一个
[0-9]                #匹配0-9中的任何一个
[!a-z]                #不匹配a-z中的任何一个
[[ $a == z* ]]        #如果$a以"z"开头(模式匹配)那么结果将为真，true $? = 1
{abc,acg,bgm}        #匹配其中任何一个字符串


(cmd)                #在子shell当中执行其中的命令
$(cmd)                #返回括号中命令的结果
((0))                #$? = 1
((5>4))                #true $? = 0常用于算术运算比较
$(())                #返回的结果是括号中表达式值


${var}                #取变量值
$*                  # 取命令行所有字符，但所有参数视为一个整体
${12}               # 取命令的第12个参数
$@                  # 取命令行所有字符，但每个参数是分开的
$#                  # 命令参数的个数
$?                  # 上一个命令的执行状态，0成功，1失败
$0                  # 获取当前 shell 本身的文件名，
$$                  # 脚本当前运行的 PID
$!                  # 后台运行的最后一个进程的 PID
$-                  # 显示当前 shell 使用的 shell option 有哪些，与set命令功能相同


'str'                #其内部的所有东西原样输出，其内部不能有''(单引号)
"str"                # $ ` \ 三个字符功能仍旧有效
`cmd`                #表示其内是命令，最后该部分内容被内部命令的执行结果替代
cmd &                #cmd命令放到后台执行
cmd1&&cmd2            #cmd1执行成功后，才执行cmd2
cmd1||cmd2            #cmd1执行失败后，才执行cmd2
cmd1;cmd2;cmd3        #连续指令分隔符

文件描述符        名称             常用缩写         默认值
    0            标准输入        stdin            键盘
    1            标准输出        stdout            屏幕
    2            标准错误输出    stderr            屏幕
cmd1 |cmd2            #管道命令:cmd1的输出当做cmd2的输入
cmd >file            #左边的命令应该有标准输出 > 右边只能是文件
cmd >>file            #输出重定向到一个文件或设备，追加原来的文件
cmd >|file            #输出重定向到一个文件或设备，强制覆盖原来的文件
cmd >!file            #输出重定向到一个文件或设备，强制覆盖原来的文件
:>file                #把文件"filename"截断为0长度.# 如果文件不存在, 那么就创建一个0长度的文件
cmd >&n             #把输出送到文件描述符n
cmd m>&n            #把输出到文件符m的信息重定向到文件描述符n
cmd >&-             #关闭标准输出
cmd >&n-             #移动输出文件描述符 n而非复制它。
注意： >&实际上复制了文件描述符，这使得cmd > file 2>&1与cmd 2>&1 >file的效果不一样。
cmd <file            #左边的命令应该需要标准输入 < 右边只能是文件
cmd << delimiter
    document
delimiter
#将两个 delimiter 之间的内容(document) 作为输入传递给 command
#注意：结尾的delimiter 一定要顶格写，前面不能有任何字符，后面也不能有任何字符，包括空格和 tab 缩进。 
cmd <<<word            #把word（而不是文件word）和後面的换行作为输入提供给cmd
cmd <>file            #以读写模式把文件file重定向到输入，文件file不会被破坏。仅当应用程序利用了这一特性时，它才是有意义的
cmd <&n             #输入来自文件描述符n
cmd m<&n             #m来自文件描述各个n
cmd <&-             #关闭标准输入
cmd <&n-             #移动输入文件描述符n而非复制它。








# Shell Output
echo -e "\"my name is\" \c"                        # 向标准输出设备输出 -e 开启转义 \c 不换行
echo "${name} It is a test"                        # 显示变量

echo "It is a test" > myfile                     # 显示结果定向至文件
echo '$name\"'                                  # 单引号里的任何字符都会原样输出，单引号字符串中的变量是无效的；
echo `date`                                     # 显示命令执行结果


#Shell printf 命令:printf  format-string  [arguments...]
    printf "%-10s %-8s %-4s\n" 姓名 性别 体重kg  
    printf "%-10s %-8s %-4.2f\n" 郭靖 男 66.1234 
    printf "%-10s %-8s %-4.2f\n" 杨过 男 48.6543 
    printf "%-10s %-8s %-4.2f\n" 郭芙 女 47.9876

    # 如果没有 arguments，那么 %s 用NULL代替，%d 用 0 代替
    printf "%s and %d \n" 
      and 0  # 注意and前面有两个空格
      
    # 格式只指定了一个参数，但多出的参数仍然会按照该格式输出，format-string 被重用
    printf "%s %s %s\n" a b c d e f g h i j
    a b c
    d e f
    g h i
    j 

    %s %c %d %f都是格式替代符
    %-10s 指一个宽度为10个字符（-表示左对齐，没有则表示右对齐），任何字符都会被显示在10个字符宽的字符内，如果不足则自动以空格填充，超过也会将内容全部显示出来。
    %-4.2f 指格式化为小数，其中.2指保留2位小数






# Shell String
string="abcdefg"
echo ${#string}                                 # 获取字符串长度，输出 7
    # Shell 字符串截取
    var=http://www.aaa.com/123.html
    echo ${var#http:}       # 从字符串头开始，删除 http: 子串
                            # 结果是 //www.aaa.com/123.html
    echo ${var#*//}         # #*// 表示从左边开始删除第一个 // 号及左边的所有字符
                            # 结果是 ：www.aaa.com/123.html
    echo ${var##*/}         # ##*/ 表示从左边开始删除最后（最右边）一个 / 号及左边的所有字符
                            # 结果是 ：123.html
    echo ${var%/*}          # %/* 表示从右边开始，删除第一个 / 号及右边的字符
                            # 结果是 ：http://www.aaa.com
    echo ${var%%/*}         # %%/* 表示从右边开始，删除最后（最左边）一个 / 号及右边的字符
                            # 结果是 ：http:
    echo ${var:0:5}         # 其中的 0 表示左边第一个字符开始，5 表示字符的总个数。
                            # 结果是：http:
    echo ${var:7}           # 其中的 7 表示左边第8个字符开始，一直到结束。
                            # 结果是 ：www.aaa.com/123.html
    echo ${var:0-7:3}       # 其中的 0-7 表示右边算起第七个字符开始，3 表示字符的个数。
                            # 结果是：123
    echo ${var:0-7}         # 表示从右边第七个字符开始，一直到结束。
                            # 结果是：123.htm
                        
echo `expr index "$string" is`                  # 反引号 ` ; 先执行反引号里面的命令，返回命令结果，查找字符 "i 或 s" 的位置，输出 8

your_name="qinjx"
greeting="hello, "${your_name}" !"
greeting_1="hello, ${your_name} !"
echo ${greeting} ${greeting_1}                  # 拼接字符串





#Shell 传递参数:在执行 Shell 脚本时，向脚本传递参数,脚本内获取参数的格式为：$n
    ./test.sh aa bb cc #其中aa bb cc为脚本参数，脚本内使用格式为: ${1} ${2} ${3} 分别对应 a b c
    
    #假设test.sh里的内容是:
    echo "传递到脚本的参数个数有：$# 个"
    echo "第一个参数为：$1"
    echo "第一个参数为：$3"
    echo "脚本运行的当前进程ID号：$$"
    echo "后台运行的最后一个进程的ID号:$!"
    
    echo "-- \$* 演示 ---"
    for i in "$*"; do        #以一个单字符串显示所有向脚本传递的参数。如"$*"用「"」括起来的情况、以"$1 $2 … $n"的形式输出所有参数。
        echo $i
    done
    #结果
    1 2 3
    
    echo "-- \$@ 演示 ---"
    for i in "$@"; do        #与$*相同，但是使用时加引号，并在引号中返回每个参数。如"$@"用「"」括起来的情况、以"$1" "$2" … "$n" 的形式输出所有参数。
        echo $i
    done
    #结果
    1
    2
    3
    
    echo "test.sh文件的退出状态：$？"        # 0表示没有错误，其他任何值表明有错误。



#Shell 基本运算符：原生bash不支持简单的数学运算，但是可以通过其他命令来实现，例如 awk 和 expr，expr 最常用。

    #以下介绍 Shell 的运算符，假定变量 a 为 10，变量 b 为 20
    #表达式和运算符之间要有空格，例如 2+2 是不对的，必须写成 2 + 2，这与我们熟悉的大多数编程语言不一样。
    #完整的表达式要被 ` ` 包含，注意这个字符不是常用的单引号，在 Esc 键下边
    #算术运算
    val=`expr $a + $b`  #加法
    val=`expr $a - $b`  #减法
    val=`expr $a \* $b` #乘法
    val=`expr $b / $a`  #除法
    val=`expr $b % $a`  #取余
    val=$b  #赋值

    val=[ $a == $b ] #相等。用于比较两个数字，相同则返回 true
    val=[ $a != $b ] #不相等。用于比较两个数字，不相同则返回 true

    #关系运算符
    [ $a -eq $b ] #检测两个数是否相等，相等返回 true
    [ $a -ne $b ] #检测两个数是否相等，不相等返回 true。
    [ $a -gt $b ] #检测左边的数是否大于右边的，如果是，则返回 true 。
    [ $a -lt $b ] #检测左边的数是否小于右边的，如果是，则返回 true。
    [ $a -ge $b ] #检测左边的数是否大等于右边的，如果是，则返回 true。
    [ $a -le $b ] #检测左边的数是否小于等于右边的，如果是，则返回 true。     

    #布尔运算
    [ ! false ]                 #非运算，表达式为 true 则返回 false，否则返回 true。
    [ $a -lt 20 -o $b -gt 100 ] #或运算，有一个表达式为 true 则返回 true。
    [ $a -lt 20 -a $b -gt 100 ] #与运算，两个表达式都为 true 才返回 true。

    #逻辑运算
    [[ $a -lt 100 && $b -gt 100 ]]  #逻辑的 AND    
    [[ $a -lt 100 || $b -gt 100 ]]    #逻辑的 OR     返回 true

    #字符串运算:假定变量 a 为 "abc"，变量 b 为 "efg"
    [ $a = $b ]     #检测两个字符串是否相等，相等返回 true。
    [ $a != $b ]     #检测两个字符串是否相等，不相等返回 true。
    [ -z $a ]         #检测字符串长度是否为0，为0返回 true。    
    [ -n $a ]        #检测字符串长度是否为0，不为0返回 true。
    [ $a ]            #检测字符串是否为空，不为空返回 true。
    
    #文件测试运算:变量 file 表示文件"/var/www/runoob/test.sh"，它的大小为100字节，具有 rwx 权限
    [ -b $file ] #检测文件是否是块设备文件，如果是，则返回 true。
    [ -c $file ] #检测文件是否是字符设备文件，如果是，则返回 true。
    [ -d $file ] #检测文件是否是目录，如果是，则返回 true。    
    [ -f $file ] #检测文件是否是普通文件（既不是目录，也不是设备文件），如果是，则返回 true。     
    [ -g $file ] #检测文件是否设置了 SGID 位，如果是，则返回 true。    
    [ -k $file ] #检测文件是否设置了粘着位(Sticky Bit)，如果是，则返回 true。    
    [ -p $file ] #检测文件是否是具名管道，如果是，则返回 true。    
    [ -u $file ] #检测文件是否设置了 SUID 位，如果是，则返回 true。    
    [ -r $file ] #检测文件是否可读，如果是，则返回 true。    
    [ -w $file ] #检测文件是否可写，如果是，则返回 true。    
    [ -x $file ] #检测文件是否可执行，如果是，则返回 true。    
    [ -s $file ] #检测文件是否为空（文件大小是否大于0），不为空返回 true。    
    [ -e $file ] #检测文件（包括目录）是否存在，如果是，则返回 true。     



#Shell test命令
    num1=100
    num2=100
    if test $[num1] -eq $[num2]
    then
        echo '两个数相等！'
    else
        echo '两个数不相等！'
    fi











#Shell 输入/输出重定向
    command > file                    #将输出重定向到 file。
    command < file                    #将输入重定向到 file。
    conmmand < file1 >file2         #同时替换输入输出
    command >> file                    #将输出以追加的方式重定向到 file。

    ####################################################
    n > file                        #将文件描述符为 n 的文件重定向到 file。
    n >> file                        #将文件描述符为 n 的文件以追加的方式重定向到 file。
    #注意：0 是标准输入（STDIN），1 是标准输出（STDOUT），2 是标准错误输出（STDERR）。
    #默认情况下，command > file 将 stdout 重定向到 file，command < file 将stdin 重定向到 file。
    #如果希望 stderr 重定向到 file，可以这样写：
    command 2 > file

    ########################################################
    n >& m                            #将输出文件 m 和 n 合并。
    n <& m                            #将输入文件 m 和 n 合并。
            

conmmand << delimiter
    document
delimiter
#将两个 delimiter 之间的内容(document) 作为输入传递给 command
#注意：结尾的delimiter 一定要顶格写，前面不能有任何字符，后面也不能有任何字符，包括空格和 tab 缩进。

    command > /dev/null #如果希望执行某个命令，但又不希望在屏幕上显示输出结果，那么可以将输出重定向到 /dev/null
