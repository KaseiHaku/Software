################################ Concept
shell> git stash            # 从 贮藏区 恢复
shell> git revert           # 将反向操作 放到一个新的 commit 中提交，用于撤销前面 commit 的修改
shell> git restore          # 将 工作区 指定 path 恢复到某个 源，也可以用来恢复 index 区
shell> git reset            # 改写历史，1: 从指定 commit 复制文件到 index/stage; 2: 将 HEAD 指向一个 commit; 



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
shell> git restore --source=tree-ish        # 指定恢复 源，默认为 index，当 --staged 存在时，默认为 HEAD
                   --staged                 # 表示以 source 为准，恢复 index 区的内容
                   --worktree               # 表示以 source 为准，恢复 worktree 区的内容
                   -- ./xxx/path/           # 恢复路径


shell> git restore -- path                                          # 因为 --staged 不存在, 所以根据 index 恢复 worktree 中指定路径的内容
shell> git restore --worktree -- path                               # 同上
shell> git restore --worktree --staged -- path                      # 因为 --staged 存在, 所以根据 HEAD 恢复 index 和 worktree 中指定路径的内容
shell> git restore --source=commit --worktree --staged  -- path     # 因为 --source=commit , 所以根据 commit 恢复 index 和 worktree 中指定路径的内容
shell> git restore --worktree --ours -- path                        # 当从 index 中恢复时，--ours 表示使用 index 覆盖 worktree，--theirs 表示使用未合并的路径
shell> git restore --worktree --theirs --merge -- path              # 当从 index 中恢复时，--theirs 表示使用未合并的路径，--merge 表示重建冲突合并


shell> git restore -s HEAD -WS -- path              # 根据 HEAD 恢复 worktree 和 staged      
shell> git restore -s HEAD -W -- path               # 根据 HEAD 仅恢复 worktree 
shell> git restore -W -- path                       # 根据 staged 恢复 worktree 





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
shell> git revert --edit commit ....        # revert commit 提交前，会让你输入 commit message
                  --mainline 2              # 一般情况下无法 revert merge commit，使用该参数指定 沿哪个 parent 所在的路径 revert
                  --cleanup=scissors        # 配置 commit message 提交之前如何 清理
                  --no-commit               # 默认自动提交，配置该参数，提交之前可以在 工作区 改东西，改完东西在 提交 revert commit
                                            # 使用该配置后，index 文件树可以不指向 HEAD，revert 会在当前所在的 commit 执行
                                            
                  








