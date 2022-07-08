# Git Merge 命令会在 stage(缓存区) 生成要合并文件的三个版本的数据，这三个版本采用数字标识
# 假设当前分支名是 A，合入的分支名为 B，
# 1: A 分支 currentCommit(HEAD) 和 B 分支 mergeCommit(HEAD) 共同的祖先版本
# 2: A 分支 currentCommit(HEAD) 的版本
# 3: B 分支 mergeCommit(HEAD) 的版本
shell> git merge B 
shell> git merge --no-ff B                  # 手工 merge

# 在合并过程中，将上面提到的 1,2,3 的版本，导出到指定文件
shell> git show :1:a.txt > a.common.txt     # 共同祖先版本
shell> git show :2:a.txt > a.ours.txt       # 当前分支的版本 
shell> git show :3:a.txt > a.theirs.txt     # 合入分支的版本

# 该命令查看 worktree 和 index 区的文件信息
shell> git ls-files -u      # -u 表示列出工作区和缓存区没有合并的文件


# 修改导出的文件
shell> dos2unix a.theirs.txt        
shell> git merge-file -p a.ours.txt a.common.txt a.theirs.txt > a.txt       # 使用修改后的 a.theirs.txt 进行合并，并输出到最初的文件名中


# 合并另一个分支的指定 commit 到当前分支
shell> git cherry-pick commitA    
shell> git cherry-pick commitA commitB
shell> git cherry-pick commitA..commitB             # 该命令会 merge (A,B] 之间的所有 commit， 不包括 A 但包括 B
shell> git cherry-pick commitA..commitB commitC..commitD

shell> git cherry-pick -e                   # cherry-pick 提交时会提示输入 commit message
                       --cleanup=mode       # 确定提交时，如何清理原来的 commit message
                       -x                   # 添加 cherry-pick 来源到 commit message 中
                       -m parent-number     # 一般情况下不能 cherry-pick merge 节点，因为不知道基于哪边开始改变的，这个参数就是指定以哪边为 主线，进行 diff 比较，从 1 开始
                       -n                   # 一般情况下 cherry-pick 会自动创建一系列提交，添加该参数，cherry-pick 会把所有改动应用到 workarea 和 index 区，而不自动 commit
                       -ff                  # 如果当前 HEAD 和 cherry-pick 出来的 commits 的父提交相同，那么采用 fast forward 方式提交
                       
                       --continue           # 解决 conflict 后，执行该命令，继续 cherry-pick
                       --skip               # 跳过当前 commit ，继续 cherry-pick 后续 commit
                       --quit               # 中止 cherry-pick，已经 pick 到当前分支的 commit 不会被回退
                       --abort              # 舍弃 cherry-pick，将分支状态回退到 cherry-pick 之前的状态
                        
