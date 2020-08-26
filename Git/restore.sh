# restore workarea: 恢复工作区
shell> git stash apply stash@{0}        # 从 stash 中恢复指定的 工作区状态
shell> git reset --hard HEAD^               # HEAD^ 上个版本， HEAD^^ 上上个版本， HEAD~100 上100个版本
shell> git reset --hard commitId            # 指定回到未来某个版本 
shell> git reset --hard origin/master       # 回到 origin 远程库的 master 分支的 HEAD 上
shell> git reset 
shell> git checkou-index -- file                   # index 区内容覆盖 work tree
shell> git restore -W --source=tree-ish -- path     # 恢复文件
shell> git checkout -- demo.txt                 # 将缓存区中的数据同步到工作区，以缓存区为准
shell> git checkout commitId -- ./fileName          # 恢复指定文件到指定 commit，此时工作区的文件已经变更，但是需要 commit 才生效    
shell> git checkout branchName -- ./fileName        # 恢复指定分支的指定文件
shell> git checkout -- fileName                     # 使用该命令放弃工作区修改，注意中间有 -- ，不加的话表示是分支名   
shell> git ls-files -d | grep repository/mongo | xargs git checkout --    # 恢复被删除的文件
shell> git checkout .                               # 该命令表示放弃工作区所有修改
shell> git checkout branchName      # 切换到指定分支，当前该分支的内容将会显示到工作区

# restore cached: 恢复缓存区
shell> git reset --mixed                    # 清空缓存区里面的所有内容，但是工作区的内容不会变，移动 HEAD 指针到指定的 commit
shell> git reset --patch tree-ish -- path       # 交互式选择 tree-ish 中不同的内容到当前 index 区 


# restore HEAD point: 恢复 HEAD 指针
shell> git reset --soft             # 仅修改 HEAD 指针，cached 和 work tree 都不修改
shell> git revert 








