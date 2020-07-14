# restore workarea: 恢复工作区
shell> git stash apply stash@{0}        # 从 stash 中恢复指定的 工作区状态
shell> git reset --hard HEAD^               # HEAD^ 上个版本， HEAD^^ 上上个版本， HEAD~100 上100个版本
shell> git reset --hard commitId            # 指定回到未来某个版本 
shell> git reset --hard origin/master       # 回到 origin 远程库的 master 分支的 HEAD 上

# restore cached: 恢复缓存区
shell> git reset --mixed


# restore HEAD point: 恢复 HEAD 指针
shell> git reset --soft             # 仅修改 HEAD 指针，cached 和 workarea 都不修改
shell> git revert 








