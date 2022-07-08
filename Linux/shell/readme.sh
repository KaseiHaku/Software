查看 Shell 的帮助
    shell> man bash
    shell> help

Shell 的启动方式：
    登录式 和 非登录式      # shell> shopt login_shell  判断是否是登录式
    交互式 和 非交互式      # shell> echo $-        返回值中有 i 字符，那么当前 shell 就是交互式
                         # shell> echo $PS1     如果非空，则为交互式，否则为非交互式
    
    组合一下就有 4 种方式：
        交互 登录:              需要输入 用户名 密码 的所有 shell 登录，例如：shell> su root
        交互 非登录:             例如: GUI 界面中的 terminal emulator 
        非交互 登录：             例如: shell> bash --login xxx.sh
        非交互 非登录：            例如: 执行 shell 脚本；shell> source xxx.sh
        
    登录式启动, shell 执行的相关脚本及顺序：
        /etc/profile -> /etc/profile.d/* -> (~/.bash_profile | ~/.bash_login | ~/.profile) -> ~/.bashrc -> /etc/bash.bashrc -> ~/.bash_logout
    非登录式启动，shell 执行的相关脚本及顺序：
        ~/.bashrc -> /etc/bash.bashrc

查看当前使用的 shell:
    shell> echo $0          # 通用
    shell> echo $SHELL      # 不一定正确


常见使用方式
    shell> if [ -e ./file ]; then echo 'file exist' ; fi        # 单行 shell 脚本的多个语句之间必须使用 ; 作为分隔符，多行语句自动以 \n 作为语句分隔符

Command Style 命令语法风格：
    UNIX 风格，选项可以组合在一起，并且选项前必须有“ - ”连字符
    BSD 风格，选项可以组合在一起，但是选项前不能有“ - ”连字符
    GNU 风格的长选项，选项前有两个“ - ”连字符
    shell> cmd -a -- file1      # -- 表示 cmd 命令的 option 选项结束， -- 之后的是命令的参数
    shell> cmd opt \            # 命令行换行输入，\ 结尾
    > another line              # 
 
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
    ?(pattern1|patten2)             # shopt -s extglob, 0-1
    *(pattern1|patten2)             # shopt -s extglob, 0-n
    +(pattern1|patten2)             # shopt -s extglob, 1-n
    @(pattern1|patten2)             # shopt -s extglob, 1
    !(pattern1|patten2)             # shopt -s extglob, 反向匹配


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
    shell> alias ls='ls --color=auto'               # 设置别名，临时
    shell> \cp -rf ./aa ./bb                        # 当 cp 存在别名时，使用 \cp 将不应用别名
    shell> unalias ls                               # 删除别名 ls，临时
    shell> cat ~/.bashrc                            # 永久 alias

重定向：
    [n]<fileName                # 当 程序 从 文件描述符 n 或 标准输入 读取数据时，打开名为 fileName 的文件，作为数据源
    [n]>fileName                # 当 程序 向 文件描述符 n 或 标准输出 写入数据时，打开名为 fileName 的文件，作为目标
    [n]>>fileName               # 追加同上
    >fileNme 2>&1               # 输出重定向到 fileName，stderr 使用 stdout 的管道，也输出到 fileName
    &>fileName                  # 同上，推荐使用这种格式，而不是下一行的格式
    >&fileName                  # 同上
    >>fileName 2>&1             # 追加
    &>>fielName                 # 同上
    
    # word 不会经过 shell 进行处理，如果 word 任何部分是引用，here-document 中的 ${var} 不会被 处理
    # delimiter 是 word 删除所有 引号 过后的值
    # 如果 word 中 任何字符 被 引号 包含，那么 here-document 中的值会被 shell 变量替换
    # - 代表删除 here-document 中的前置 tab 字符
    [n]<<[-]word                # 该格式的作用是，以 here-document 作为 输入源
        here-document
    delimiter                   
    
    [n]<<<word                  # word 经过 shell 处理后，然后作为 文件描述符 n 的输入
    
    [n]<&word                   # 复制文件描述符
    [n]>&word
    [n]<&digit-                 # 移动文件描述符
    [n]>&digit-
    [n]<>word                   # 重定向，同时读写，n 不存在默认为 0


    # 左边的命令应该有标准输出 > 右边只能是文件
    # 左边的命令应该需要标准输入 < 右边只能是文件
    
    [FILE_DESCRIPTOR]>                           # 输出重定向到一个文件或设备 覆盖原来的文件
    [FILE_DESCRIPTOR]>!                          # 输出重定向到一个文件或设备 强制覆盖原来的文件
    [FILE_DESCRIPTOR]>>                          # 输出重定向到一个文件或设备 追加原来的文件
    <[FILE_DESCRIPTOR]                           # 输入重定向到一个程序
    

    # 重定向案例分析
        cmd >a 2>a  => 等价于 cmd 1>a 2>a  => stdout和stderr都直接送往文件 a ，a文件会被打开两遍，由此导致stdout和stderr互相覆盖。
        cmd >a 2>&1 => 等价于 cmd 1>a 2>&1 => stdout直接送往文件a ，stderr是继承了FD1的管道之后，再被送往文件a 。a文件只被打开一遍，就是FD1将其打开。

        2>&1 => 这个命令格式是：2 文件的输出重定向动作跟 1 文件的重定向动作相同，或者可以理解为 2 先把输出重定向到 1，然后 1 再重定向到 a
        如果命令格式如下：
        cmd 2>&1 1>a  =>  2>&1 标准错误拷贝了标准输出的行为，但此时标准输出还是在终端。>file 后输出才被重定向到file，但标准错误仍然保持在终端。    
        
        &1 的意思是：引用 文件描述符1 现在的值(如果 1 已经被重定向，则引用 1 重定向后的值)
        
        
    # 重定向到多个文件
    # tee 命令：将 标准输入 复制到每个指定文件，并显示到 标准输出
    shell> echo 'aaaa' | tee file       # 将 标准输入 复制一份，一份输出到 标准输出，一份输出到 file
    shell> echo 'aaaa' | tee -a file    # 同上，只是向 file 中追加，而不是覆盖
    shell> echo 'aaaa' | tee -          # 将 标准输入 复制一份，两份都输出到 标准输出

FD = File Descriptor = 文件描述符: 
    Linux 系统中一切皆文件，当进程打开现有文件或创建新文件时，内核向进程返回一个文件描述符。
    文件描述符就是内核为了高效管理已被打开的文件所创建的索引，用来指向被打开的文件，所有执行I/O操作的系统调用都会通过文件描述符

    Linux 三个标准输入、输出文件：
        /dev/stdin      文件描述符 0         标准输入文件
        /dev/stdout     文件描述符 1         标准输出文件
        /dev/stderr     文件描述符 2         标准错误输出文件
    
        shell> cmd <                # 相当于 cmd < 0
        shell> > /dev/null          # 相当于 1 > /dev/null


管道命令：就是把 左边命令 原本输出到 /dev/stdout(1) 的数据 重定向成 右边命令 的 /dev/stdin(0) 输入 

    # 左边的命令应该有向 /dev/stdout 文件写入操作 | 右边的命令应该有从 /dev/stdin 读取的操作
    ls -al /dev | grep 'cdrom'                # 管道命令：将前面的最后一次的标准输出作为后面的标准输入，坑：不包括之前输出的
    
    # 部分命令 不能 grep 的原因：因为部分命令将输出打到了 /dev/stderr(2) 上了，而 grep 只接收 /dev/stdin(0) 的数据
    shell> ip | grep c          # grep 没有生效
    shell> ip 2>&1 | grep c     # 把输出到 FD2 的数据 重定向 到 FD1 当前活动的管道中，不能直接 2>1 


Shell 信息查询
    shell> history                      # 查看控制台命令历史, 快捷键 Ctrl+R 反向搜索命令，再次 Ctrl+R 搜索上一个
    shell> type -t cmd                  # 可以显示 build-in, alias, cmd path
    shell> typeset -f func              # 查看 func 函数的实际定义内容

    
直接在控制台输出
    shell> echo "kasei haku"        # 直接输出到终端
    shell> echo -e "123\n456"         # echo 解析转义字符

Shell 的可配置项 shopt(shell option)
    shell> shopt                    # 查看所有选项，并显示选项当前状态
    shell> shopt -s optionName      # 开启某个选项
    shell> shopt -u optionName      # 关闭某个选项
    shell> shopt -p                 # 列出所有可配置的选项
    shell> shopt -s extglob         # 开启该选项，该选项允许使用表达式匹配路径

Date:
    shell> date -d @1 '+%Y-%m-%d %H:%M:%S.%N'   # @1 表示从 1970-01-01 UTC 开始的毫秒数，而不使用当前时间
                                                # '+%Y-%m-%d %H:%M:%S.%N' 表示时间输出格式，必须 + 开头，%N=纳秒
