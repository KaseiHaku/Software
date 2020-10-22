# Git Merge 命令会在 stage(缓存区) 生成要合并文件的三个版本的数据，这三个版本采用数字标识
# 假设当前分支名是 A，合入的分支名为 B，
# 1: A 分支 currentCommit(HEAD) 和 B 分支 mergeCommit(HEAD) 共同的祖先版本
# 2: A 分支 currentCommit(HEAD) 的版本
# 3: B 分支 mergeCommit(HEAD) 的版本
shell> git merge B 

# 在合并过程中，将上面提到的 1,2,3 的版本，导出到指定文件
shell> git show :1:a.txt > a.common.txt     # 共同祖先版本
shell> git show :2:a.txt > a.ours.txt       # 当前分支的版本 
shell> git show :3:a.txt > a.theirs.txt     # 合入分支的版本

# 该命令查看 worktree 和 index 区的文件信息
shell> git ls-files -u      # -u 表示列出工作区和缓存区没有合并的文件


# 修改导出的文件
shell> dos2unix a.theirs.txt        
shell> git merge-file -p a.ours.txt a.common.txt a.theirs.txt > a.txt       # 使用修改后的 a.theirs.txt 进行合并，并输出到最初的文件名中


# 合并指定 commit 到另一个分支
shell> git cherry-pick commitA    
shell> git cherry-pick commitA commitB
shell> git cherry-pick commitA..commitB             # 该命令会 merge (A,B] 之间的所有 commit， 不包括 A 但包括 B
shell> git cherry-pick commitA..commitB commitC..commitD
