# Linux 命令帮助语法
# <xxx>                 必填参数，位置参数
# -o                    短格式选项，可以间隔 0~n 个空格指定参数内容，即：shell> cmd -ofile  或 shell> cmd -o    file (推荐)
# --output              长格式选项，shell> cmd --output     file 或 shell> cmd --output=file (推荐)
# [xxx]                 [] 内部表示可选项
# (xxx)                 () 内部表示必选项，[(xxx)] 表示可选的必选项
# (xxx | yyy | zzz)     (|) 必选互斥项
# [xxx | yyy | zzz]     [|] 可选非互斥项
# {xxx | yyy | zzz}     {|} 必选互斥项
# [xxx ...]             ... 表示可以重复多次
# [options]             表示可选项的占位符
# [--]                  用于分隔 选项  和 位置参数
# [-]                   当不是选项的一部分时，一个破折号“-”通常用于表示程序应该处理stdin，而不是文件

