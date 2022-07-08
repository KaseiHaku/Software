################################ restore workarea: 恢复工作区
#### git stash
shell> git stash apply stash@{0}        # 从 stash 中恢复指定的 工作区状态

#### git checkout
shell> git checkout -- demo.txt                 # 将缓存区中的数据同步到工作区，以缓存区为准
shell> git checkout commitId -- ./fileName          # 恢复指定文件到指定 commit，此时工作区的文件已经变更，但是需要 commit 才生效    
shell> git checkout branchName -- ./fileName        # 恢复指定分支的指定文件
shell> git checkout -- fileName                     # 使用该命令放弃工作区修改，注意中间有 -- ，不加的话表示是分支名   
shell> git ls-files -d | grep repository/mongo | xargs git checkout --    # 恢复被删除的文件
shell> git checkout .                               # 该命令表示放弃工作区所有修改
shell> git checkout branchName      # 切换到指定分支，当前该分支的内容将会显示到工作区
shell> git checkout commitId -b newBranchName       # 从指定 commit 切出新分支

#### git restore
shell> git restore -- path                                          # 因为 --stage 不存在, 所以根据 index 恢复 worktree 中指定路径的内容
shell> git restore --worktree -- path                               # 同上
shell> git restore --worktree --stage -- path                       # 因为 --stage 存在, 所以根据 HEAD 恢复 index 和 worktree 中指定路径的内容
shell> git restore --worktree --stage --source=commit -- path       # 因为 --source=commit , 所以根据 commit 恢复 index 和 worktree 中指定路径的内容
shell> git restore --worktree --ours -- path                        # 当从 index 中恢复时，--ours 表示使用 index 覆盖 worktree，--theirs 表示使用未合并的路径
shell> git restore --worktree --theirs --merge -- path              # 当从 index 中恢复时，--theirs 表示使用未合并的路径，--merge 表示重建冲突合并




#### git reset
shell> git reset --hard HEAD^               # HEAD^ 上个版本， HEAD^^ 上上个版本， HEAD~100 上100个版本
shell> git reset --hard commitId            # 指定回到未来某个版本 
shell> git reset --hard origin/master       # 回到 origin 远程库的 master 分支的 HEAD 上
shell> git reset --merge HEAD               # 清空缓存区，更新工作区跟 HEAD 不同的文件，保留工作区未 commit 的数据
shell> git reset --keep commit1             # 清空缓存区，重置工作区中，当前 HEAD 指针指向的 commit 和 commit1 不同的文件

#### git checkout-index
shell> git checkout-index -- file                   # index 区内容覆盖 work tree




################################ restore cached: 恢复缓存区
shell> git restore --stage --source=tree-ish -- path     # 从指定的 tree-ish 恢复文件到 index 中


shell> git reset --mixed                    # 清空缓存区里面的所有内容，但是工作区的内容不会变，移动 HEAD 指针到指定的 commit
shell> git reset --patch tree-ish -- path       # 交互式选择 tree-ish 中不同的内容到当前 index 区 


################################ restore HEAD point: 恢复 HEAD 指针
shell> git reset --soft             # 仅修改 HEAD 指针，cached 和 work tree 都不修改
shell> git revert 








