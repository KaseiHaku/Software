# 清理
shell> git gc


################################## Plumbing Commands 管道命令 ###############################


# 
shell> git verify-pack -v  .git/objects/pack/pack-*.idx

#
shell> git rev-list 
# 重写分支
shell> git filter-branch
# 验证数据库中对象的 连通性 和 有效性
shell> git fsck


################################ Git Plumb Tool Usage ################################
shell> git rev-parse branchName                 # 查看指定 branch 指向哪个 commit

shell> git reflog                       # 用于查看最近几个月的 HEAD 和 branch 引用的指向历史，引用日志不会提交到远程，只存在本地仓库

shell> git log master..branch1          # 查看 branch1 中有哪些 commit 没有合并到 master 中
shell> git log origin/master..HEAD      # 查看 HEAD 中有哪些 commit 没有合并到 origin/master 中
shell> git log refA refB --not refC     # 查看所有被 refA 和 refB 包含的 commit ，但是不被 refC 包含的 commit
shell> git log --left-right master...branch1         # 查看仅仅在 master 或者 branch1 中存在的 commit，即: 单边存在，--left-right 可以显示 commit 仅仅存在于在哪边的分支上

shell> git add -i               # 交互式界面
shell> git add --patch          # 暂存一个文件中的部分修改，而不是全部修改


shell> git grep                 # 从 提交历史，工作目录，索引 中查找字符串 和 正则表达式，默认查找 工作目录

shell> git commit --amend       # 修改提交信息
shell> git rebase -i            # 修改 commit 顺序，拆分一个 commit，合并多个 commit 等
shell> git filter-branch            # 通过脚本的方式，改写大量提交，例如：从每个提交中移除一个文件，全局修改邮箱地址 等，这个命令有很多 坑，不熟悉最好别用，可以使用 git-filter-repo 替代

# --tree-filter：检出项目的每一个 commit，并执行指定的 cmd，然后再重新提交
# --all: 可以让 git filter-branch 在所有分支上执行
shell> git filter-branch --tree-filter 'rm -f passwords.txt' HEAD   
shell> git filter-branch --subdirectory-filter trunk HEAD               # 修改项目 根目录 为指定 子目录




shell> git rev-list             # 按提交时间，逆序列出 commit objects 
