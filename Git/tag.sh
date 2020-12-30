# 什么是 tag: tag 是一个指针，指向一个 commit
# tag 的作用: 纯粹是为了给一个 commit 打个标记，取个名字，方便以后查询


# 创建 tag
shell> git tag -am 'tag message' tagName commitId   # 如果没有 commitId，默认取当前 beanch 的 HEAD 作为 commitId  


# 删除 tag
shell> git tag -d tag1 tag2 ...

# 查看 tag
shell> git tag -l           # 查看所有 tag
shell> git tag -v tagName   # 查看指定 tagName 的详细信息

# 将标签提交到 remote repository
shell> git push origin --tags   # 推送所有标签到 remtoe repo
shell> git push origin tagName  # 推送指定的标签到 remote repo
