Vim All Mode {
    " 单模式
    Normal                          nnoremap                        键入的字符是 命令, <ESC> 进入该模式
    OperatorPending                 onoremap                        例如: Normal Mode 中按 d 光标会变成 半个, 这是就是这种模式 

    Insert                          inoremap                        i a o 进入该模式
    Replace                         inoremap

    Visual                          xnoremap                        键入的字符是 命令, v 进入该模式, V 进入行模式, Ctrl+V 进入块模式
    Select                          snoremap                        类似于 Visual Mode 但是键入的字符会替换 选区


    CommandLine                     cnoremap
    Ex                                                              多行 Command-line, Q 或 gQ 进入该模式, :vi 或 :q 退出该模式

    Lang-Arg                                                        任何输入的字符是缓冲区文本的一部分而非一个 Vim 命令字符的时候

    Terminal                        tnoremap

    " 组合模式
    Normal, Visual, Select, Operator Pending        noremap
    Insert, Replace                                 inoremap
    Visual, Select                                  vnoremap
    Insert, CommandLine                             noremap!
    Insert, CommandLine, Lang-Arg                   lnoremap
}

Help {
    :help x                     # Normal 模式下 x 命令的帮助
    :help v_x                   # Visual 模式下 x 命令的帮助
    :help i_<Esc>               # Insert 模式下 <Esc> 命令的帮助
    :help :quit                 # Command 模式下 :quit 命令的帮助
    :help c_<Del>               # Command-edit 模式下 <Del> 命令的帮助
    :help -r                    # shell> vim -r 中 -r 命令参数的帮助
    :help 'textwidth'           # Option 
    :help /[                    # Regexp 模式下 [ 字符的帮助
    
    Help 文档内的跳转 {
        Ctrl-]                  # 就可以跳转到和当前光标所在单词相关的帮助信息
        Ctrl-T                  # 切换回 Ctrl-] 原来的位置
        Ctrl-O                  # 在前后浏览过的帮助信息之间进行切换。
        Ctrl-I                  # 在前后浏览过的帮助信息之间进行切换。
        CTRL-D                  # 查看匹配的其他帮助
    }
    
    
    :h <name>                   # 查看命令的帮助文档
    :help number<Ctrl-D>        # 列出显示当前输入的相关帮助, 使用 <Tab> 选中不同的列表项
    :helpgrep pattern           # :cnext 到下一个
                                # :cwindow 打开 quickfix window
    :exu[sage]                  # Show help on Ex commands.
    :viu[sage]                  # Show help on Normal mode commands.

    
    
    :help ins-special-keys      # 查看左右 insert mode 下的 特殊键

}


Vim Comprehensive Information {
    :help                           # vim help 文档
    :version                        # 显示 vim 版本, 启用的特性及默认 vimrc 配置文件加载路径
    :scriptnames                    # 按加载顺序显示 vim 启动后所有 script 
    :set runtimepath?               # 显示 script 搜索路径
    
    :set                            # 查看 vim 当前所有被修改过的配置项值
    :set all                        # 查看 vim 所有的可配置项
    :map                            # 查看所有映射
    :function                       # 查看加载的所有 function   
    :registers                      # 查看所有寄存器
}





Vim Set {
    :set runtimepath?               # 显示 script 搜索路径
    :set                            # 查看 vim 当前所有被修改过的配置项值
    :set all                        # 查看 vim 所有的可配置项
    :set {option}?                  # 查看当前 option 选项的值
    :echo &option                   # 同上
    
    :set no{option}                 # 关闭 布尔值 选项
    :set inv{option}                # 反转 布尔值 option
    :set {option}={value}           # 设置字符串/数值选项的值为 {value}
    :set {option}+={value}          # 将 {value} 附加到字符串选项里，将 {value} 加到数值选项上
    :set {option}-={value}          # 从 {value} 从字符串选项里删除，从数值选项里减去 {value}
    
    :set option&                    # 重置 option 选项为 vim 默认值
    :set option!                    # toggle 当前 option 的值
    :verbose set option?            # 查看 option 配置项的值最终是在哪里被设置
    :set <Tab>                      # 可以通过 <Tab> 键进行切换到一条信息，或者使用 Ctrl-P/Ctrl-N 进行前后切换     
    
    
    :set termcap                    # 显示所有的终端选项。注意 在 GUI 里，不会显示键码，因为它们是内部生成的，无法改变。而且 GUI 里即使修改终端代码也没用
    :set term=xxx                   # 显示 term 选项所有的 可选值
    
}

Key Code(键码) {

    什么是 键码? 相当 vim 自己维护的一个 键盘，vim 只认识这些 键码
    什么是 键码 映射? 因为 键盘输出的 键码 跟 vim 的键码 不一定匹配，导致 vim 无法识别，所以需要配置 键码 映射，将 键盘的键码 映射到 vim 的 keycode 上
    
    
    如果 vim 在 terminal 中运行，那么 vim 接收到 键盘 keycode 的全过程:
        键盘按键(单键 or 组合键) -> 键盘 keycode(单个 keycode or 多个 keycode) -> OS -> 一般不转码 -> Terminal -> 转码 -> Vim
   
    查看 键盘 上的按键，软件实际接收到的 字符序列：
        terminal: shell> cat Ctrl+A             # 就能看到 terminal 实际接收到的字符序列
        vim: 命令行模式下 Ctrl+V Ctrl+A           # 就能看到 vim 实际接收到的字符序列
        
   

    vim 按键映射在 GUI 模式下的支持都很完善，但是 vim 在 terminal 中使用时，vim 接收的按键是经过 terminal 处理的，例如:
        terminal key code: ^[ = ESC; 
        vim key code: <S-Up>;                   # Vim 的 keycode 具有字面含义, 因为他要运行在不同的系统上; @help :help c_CTRL-V
    
    配置键码映射：
        :set <C-a>=^A           # vim 将接收到 ^A 字符序列，当作 Ctrl+A 处理
    
}


FAQ: {
    Question: gvim 每行后面出现 ^M 等标记
    Cause: 当前文本文件中, 混用了 window(\r\n) linux(\n) mac(\r) 的换行格式
    Solution: 替换所有换行格式为一种类型, :%s/\r\(\n\)/\1/g
}


