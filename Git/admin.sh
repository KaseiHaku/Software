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



