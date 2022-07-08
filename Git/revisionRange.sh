# 修订范围
shell> git log <sha1>                           # 通过 SHA-1 指定修订范围
shell> git log dae86e         

shell> git log <describeOutput>                 # 通过 tag 来指定修订范围
shell> git log v1.7.4.2-679-g3bee7fb

shell> git log <refname>                        # 通过 引用名/分支名 来指定修订范围
shell> git log refs/heads/master
shell> git log @                                # @ 是 HEAD 的 快捷键

shell> git log [<refname>]@{<date>}             # 通过 引用名+时间偏移 来指定修订范围
shell> git log master@{yesterday}

shell> git log <refname>@{<n>}                  # 通过 引用名+提交偏移数 来指定修订范围
shell> git log master@{1}                       # master 分支 到 master 分支当前提交的 前 1 个提交

shell> git log @{<n>}                           # 默认使用 当前分支+提交偏移数 来指定修订范围 
shell> git log @{1}

shell> git log @{-<n>}                          # 先 检出 branchA 然后 检出 branchB 
shell> git log @{-1}                            # 先 检出 branchA 然后 检出 branchB，@{-1} 表示回到 branchA

shell> git log [<branchname>]@{upstream}

shell> git log [<branchname>]@{push}


shell> git log <rev>^[<n>]                      # 表示指定 revision 的第 n 个 parent 提交，父提交的父提交，爷爷提交
shell> git log <rev>~[<n>]                      # 表示指定 revision 的第 n 个 parent 提交，合并节点有多个 parent

shell> git log <rev>^{<type>}                   # 解析引用
shell> git log <rev>^{commit}                   # 表示引用 revision 指向的 commit 实例         
shell> git log <rev>^{tree}                     # 表示引用 revision 指向的 tree 实例      
shell> git log <rev>^{object}                   # 表示引用 revision 指向的 object 实例      
shell> git log <rev>^{tag}                      # 表示引用 revision 指向的 tag 实例      
shell> git log <rev>^{}                         # 表示 递归 解析引用，知道找到一个 非引用 实例

shell> git log <rev>^{/<text>}                  # 找到最近的 commit message 符合 text 所表示的 正则表达式的 提交
shell> git log :/<text>                         
shell> git log :/!!foo                          # 因为 :/! 是保留字段，所以这里 :/!!foo 实际为 !foo
shell> git log :/!-foo                          # :/-  表示反向匹配

shell> git log <rev>:<path>                     # 匹配指定 commit 中，有对指定文件进行修改的 commit

# 当合并分支时
# n=0   表示当前 index/stage 区
# n=1   表示共同祖先的 版本
# n=2   表示合入分支分支的 版本
# n=3   表示被合入分支的 版本
shell> git log :[<n>:]<path>                    

^<rev>              # caret 表示在符合匹配的 commit 中 剔除掉指定 commit
r1..r2              # ^r1 r2， 可以从 r2 的祖先，但不是 r1 的祖先
r1...r2             # r1 的祖先 或者 r2 的祖先，但不是 r1 r2 共同的祖先
r1^@                # 包含所有 祖先，但是排除掉自己
r1^!                # 排除掉所有 祖先
<rev>^-[<n>]        # 等价于 <rev>^<n>..<rev>，如果 n 不存在，则相当于 n=1



