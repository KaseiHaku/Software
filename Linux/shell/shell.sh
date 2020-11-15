Command Style 命令语法风格：
    UNIX 风格，选项可以组合在一起，并且选项前必须有“ - ”连字符
    BSD 风格，选项可以组合在一起，但是选项前不能有“ - ”连字符
    GNU 风格的长选项，选项前有两个“ - ”连字符
    shell> cmd -a -- file1      # -- 表示 cmd 命令的 option 选项结束， -- 之后的是命令的参数
 
命令行中各种字符的含义：
    ''                  # 单引号，表示单引号内部的符号全部都是字符，不转义
    ""                  # 双引号，内部字符 $（参数替换） 和 `（命令替换） 是生效的
    ()                  # 起一个 子shell 并执行其中的命令，并将输出返回
    [[...]]             # 用作 if 条件判断的条件
    {}                  # 在当前 shell 中执行命令，并将输出返回

Wildcard 命令通配符：
    *                               # 匹配 0 或多个字符
    ?                               # 匹配任意一个字符
    [list]	                        # 匹配 list 中的任意单一字符
    [!list]	                        # 匹配 除list 中的任意单一字符以外的字符
    [c1-c2]	                        # 匹配 c1-c2 中的任意单一字符 如：[0-9] [a-z]
    {string1,string2,...}	          # 匹配 sring1 或 string2 (或更多)其一字符串
    {c2..c2}	                      # 匹配 c1-c2 中全部字符 如{1..10}


Command Format 命令格式：
    command [option] [arguments]
    command1 ; command2 ; command3                 # 顺序执行命令，不管前一条命令是否执行成功
    command1 && command2 && command3               # 前一条命令退出码为 0（成功），才继续执行后面命令
    command1 || command2 || command3               # 前一条命令退出码为 非0（失败），才继续执行后面命令
    cmd1 | ( cmd2; cmd3; cmd4 ) | cmd5             # 子 shell ，子 shell 里面的所有东西只属于 子 shell，不影响 父shell
    
Linux 执行脚本文件的方式：
    shell> source /etc/profile          # 在当前 进程 中执行，不需要文件有执行权限
    shell> . /etc/profile               # 同上
    shell> bash /etc/profile            # 启创建子进程，执行该文件，不需要文件有执行权限
    shell> sh /etc/profile              # 同上
    shell> /etc/profile                 # 创建子进程，需要文件有执行权限

Linux 查看当前 Terminal 所有可以运行的命令
    shell> compgen -c                   # 列出所有可运行的命令
    shell> compgen -a                   # 列出所有可运行的 alias
    shell> compgen -b                   # 列出所有可运行的 build-in
    shell> compgen -k                   # 列出所有 keyword
    shell> compgen -A function          # 列出所有可运行的 function


# alias 指令别名
shell> alias                                    # 查看当前所有别名
shell> alias ls='ls --color=auto'               # 设置别名 

重定向：
    # 左边的命令应该有标准输出 > 右边只能是文件
    # 左边的命令应该需要标准输入 < 右边只能是文件

    >                           # 输出重定向到一个文件或设备 覆盖原来的文件
    >!                          # 输出重定向到一个文件或设备 强制覆盖原来的文件
    >>                          # 输出重定向到一个文件或设备 追加原来的文件
    <                           # 输入重定向到一个程序

# 重定向案例分析
cmd >a 2>a  => 等价于 cmd 1>a 2>a  => stdout和stderr都直接送往文件 a ，a文件会被打开两遍，由此导致stdout和stderr互相覆盖。
cmd >a 2>&1 => 等价于 cmd 1>a 2>&1 => stdout直接送往文件a ，stderr是继承了FD1的管道之后，再被送往文件a 。a文件只被打开一遍，就是FD1将其打开。

2>&1 => 这个命令格式是：2 文件的输出重定向动作跟 1 文件的重定向动作相同，或者可以理解为 2 先把输出重定向到 1，然后 1 再重定向到 a
如果命令格式如下：
cmd 2>&1 1>a  =>  2>&1 标准错误拷贝了标准输出的行为，但此时标准输出还是在终端。>file 后输出才被重定向到file，但标准错误仍然保持在终端。                          



Linux 三个标准输入、输出文件：
    /dev/stdin      文件描述符 0         标准输入文件
    /dev/stdout     文件描述符 1         标准输出文件
    /dev/stderr     文件描述符 2         标准错误输出文件
    
    shell> cmd <                # 相当于 cmd < 0
    shell> > /dev/null          # 相当于 1 > /dev/null


管道命令： 就是把左边命令的输出 转换成 右边命令的输入

    # 左边的命令应该有向 /dev/stdout 文件写入操作 | 右边的命令应该有从 /dev/stdin 读取的操作
    ls -al /dev | grep 'cdrom'                # 管道命令：将前面的标准输出作为后面的标准输入



    





# grep 命令简介
# 作用： 只显示包含指定 pattern 的行
shell> grep -i pattern file1 file2                     # 忽略大小写
grep -n pattern file1 file2                     # 输出匹配串在文件中的行号
grep -r pattern file1 file2                     # 递归搜索子目录
grep --color=auto pattern file1 file2           # 匹配字符串高亮显示
grep -E pattern file1 file2                     # 表示 pattern 是一个正则表达式
grep -f fileRegexp file1 file2                  # 从文件中读取 pattern ，文件中一行为一个 pattern， 命令匹配所有文件中的 pattern
grep -v 反选


    
    


# xargs 命令简介
# 作用： 将标准输入转换成命令的参数，默认拼接在命令的最后
# 定界符： 默认定界符是 空格， xargs 命令会把输入的字符串中的 换行 和 其他空白字符 替换成空格
xargs [option] command [command-option]
    -a file         # 从指定文件读入输入，而不是标准输入中
    -d ,            # 修改分隔符
    -i              # 使用 {} 作为占位符标记，可以使用 --replace=[R] 替换默认的占位符 {}
    -n 1            # 一次命令使用多少个分隔符
    -l 1            # 一个 xarg 命令最多使用输入中的多少个非空行
    
    
echo 1 2 3 | xargs -n 1 touch                       # 每行输出 1 个，然后将每行的字符串作为后面命令的参数
echo ggXaaXhh | xargs -d X -n 1 echo                # 修改定界符为 'X'
echo kasei | xargs -I {} ./sk.sh -p {} -l           # -I 指定占位符为 {}， 命令行中的 {} 将被传入的参数所替代 



# 查看控制台命令历史
shell> history      # 快捷键 Ctrl+R 反向搜索命令，再次 Ctrl+R 搜索上一个
    
直接在控制台输出
    shell> echo "kasei haku"        # 直接输出到终端
    
shopt(shell option)
    shell> shopt                    # 查看所有选项，并显示选项当前状态
    shell> shopt -s optionName      # 开启某个选项
    shell> shopt -u optionName      # 关闭某个选项
    shell> shopt -p                 # 列出所有可配置的选项
    shell> shopt -s extglob         # 开启该选项，该选项允许使用表达式匹配路径



