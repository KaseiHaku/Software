坑：
    1. 千万不能用 window 记事本编辑文本文件，下载 UltraEdit 修改默认编码格式为： UTF-8 without BOM
    2. 所有版本控制系统都只能跟踪 txt 文件的改动，二进制文件虽然能管理，但是不能跟踪改动
    3. 假如 remoteRepository 有个分支叫 branchDev，localRepository 也有个分支叫 branchDev ，注意这两个分支虽然同名但是不是一个分支，在 git push 的时候，还是会进行 merge 操作
       git pull = git fetch + git merge origin/branchId
       git push = git fetch + git merge origin/branchId + git push 


帮助:
    shell> git -h
    shell> git help -a
    shell> git help command/concept     # 查看某个 命令 和 概念 的帮助
    shell> git help git                 # 查看整体概览


.git 目录结构介绍：
    .git 
      │
      ├─ hooks          # 钩子程序，可以被用于在执行git命令时自动执行一些特定操作，例如加入changeid
      ├─ info
      ├─ logs
      ├─ objects    # shell> git cat-file -p SHA  查看对象的内容        shell> git cat-file -t SHA   查看对象的类型，有 commit, tree, blob     
      │     ├─ ff                                                       # 2 个字符            
      │         ├─ d3915176744e0a58694763b5a5ec354d29f632               # 38 个字符，和 父目录名+当前文件名 = Object 的 SHA-1 哈希值
      │     ├─ info
      │     ├─ pack
      ├─ refs               # 保存 branch 和 tag 的信息
      ├─ COMMIT_EDITMSG
      ├─ config             # 当前仓库配置信息
      ├─ description
      ├─ FETCH_HEAD
      ├─ HEAD               # 工作目录当前状态对应的 commit
      ├─ index
      ├─ ORIG_HEAD
      └─ packed-refs
  
Glossary:
    @doc https://git-scm.com/docs/gitglossary
    
    working tree: 当前 工作区 中所有文件组成的树
    index: working tree 中确定提交的版本，即: 缓存区 的内容
    
    ref:
        以 refs/ 开头的，指向 object 或 另一个 ref 的。例如: refs/heads/master  对应 .git/refs/heads/master
        ref 大多数情况下可以缩写：
            @doc https://git-scm.com/docs/gitrevisions#Documentation/gitrevisions.txt-emltrefnamegtemegemmasterememheadsmasterememrefsheadsmasterem
        ref 查找顺序:
            1   .git/<refname>
            2   .git/refs/<refname>
            3   .git/refs/tags/<refname>
            4   .git/refs/heads/<refname>
            5   .git/refs/remotes/<refname>
            6   .git/refs/remotes/<refname>/HEAD
            7   除了搜索 .git/refs 目录，还会查找 .git/packed-refs
            



Git 的本质：
    Essence:
        git 是以 commit 为节点，组成的一个有向无环图(DAG)，所有 commit 之间形成一颗提交树
    
    Concept/Objects:
        commit: 用于表示一次提交，以提交来记录每一次的文件变动
        tree: 用于保存一次提交相关的所有文件的索引
        blob: 就是文件系统中的文件
        关系: Commit - 1:1 - Tree - 1:n - Blob
    
    RefSpec 引用规范：
        格式：+<src>:<dst>         
        其中 + 可选，+ 号告诉 Git 即使在不能快进的情况下也要（强制）更新引用。
    
    Identifier: 英文中 -ish 后缀用来表示 像...似的 的意思, 例如: childish = child-ish  的意思为: 像孩子似的, 幼稚的, 孩子气的
        |    Commit-ish/Tree-ish    |                Examples
        ----------------------------------------------------------------------
        |  1. <sha1>                | dae86e1950b1277e545cee180551750029cfe735
        |  2. <describeOutput>      | v1.7.4.2-679-g3bee7fb
        |  3. <refname>             | master, heads/master, refs/heads/master
        |  4. <refname>@{<date>}    | master@{yesterday}, HEAD@{5 minutes ago}
        |  5. <refname>@{<n>}       | master@{1}
        |  6. @{<n>}                | @{1}
        |  7. @{-<n>}               | @{-1}
        |  8. <refname>@{upstream}  | master@{upstream}, @{u}
        |  9. <rev>^                | HEAD^, v1.5.1^0
        | 10. <rev>~<n>             | master~3
        | 11. <rev>^{<type>}        | v0.99.8^{commit}
        | 12. <rev>^{}              | v0.99.8^{}
        | 13. <rev>^{/<text>}       | HEAD^{/fix nasty bug}
        | 14. :/<text>              | :/fix nasty bug
        ----------------------------------------------------------------------
        |       Tree-ish only       |                Examples
        ----------------------------------------------------------------------
        | 15. <rev>:<path>          | HEAD:README.txt, master:sub-directory/
        ----------------------------------------------------------------------
        |         Tree-ish?         |                Examples
        ----------------------------------------------------------------------
        | 16. :<n>:<path>           | :0:README, :README
    
    Caret(^) 和 Tilde(~) 的区别:
        G   H   I   J
         \ /     \ /
          D   E   F
           \  |  / \
            \ | /   |
             \|/    |
              B     C
               \   /
                \ /
                 A
                 
        A =      = A^0
        B = A^   = A^1     = A~1
        C = A^2
        D = A^^  = A^1^1   = A~2
        E = B^2  = A^^2
        F = B^3  = A^^3
        G = A^^^ = A^1^1^1 = A~3
        H = D^2  = B^^2    = A^^^2  = A~2^2
        I = F^   = B^3^    = A^^3^
        J = F^2  = B^3^2   = A^^3^2
       
    常见 commit filter:
        shell> git log A..B         # 查询 B 分支中 A 没有的 commit
        shell> git log A...B        # 查询在 A B 分支中，只存在一边的 commit

Git Terminology:
    Workarea(WorkTree) = untracked + indexed: 就是当前正在编辑的版本，即: 文件系统中的内容
        untracked: 没有被 git 管理跟踪的文件
        indexed: 已经被 git 管理跟踪的文件，
    Cached(Staging, Index) : 缓存区：从工作区提交，但是还没有放入到本地仓库的版本，即: 下一次 commit 的 snapshot
    LocalRepository: 本地仓库：存储在本地仓库中的版本
    RemoteRepository: 远程仓库：存储在远程仓库中的版本，比如：存储在 GitHub 服务器中的版本 
    Stash: 临时保存工作区的状态

    
Git Reference
    Branch: 指向一个 Commit 
    HEAD: 当前正在编辑的 Commit 的 parent commit
    Tag: 指向一个 Commit
    Remote: 可以有多个 remote 仓库，命令行中的使用方式 远程仓库名/分支名，例如： origin/dev

Git 中文件状态的改变，例如一下操作仅针对一个文件 H.txt
      未跟踪           未修改             已修改            缓存区              本地仓库            关联关系库             远程仓库
    untracked       unmodified          modified          staged            localRepo       associateRelationRepo  remoteRepo
        |  - git add ->  |                  |               |                   |                  |                   |
        |                | - edit file ->   |               |                   |                  |                   |
        |                |                  |  - git add -> |                   |                  |                   |
        |                |                  |               | - git commit ->   |                  |                   |
        |                |                  |               |                   |  - git push ->   |                   |
        |                |                  |               |                   |  ----------- git push ---------->    |
        |                |                  |               |                   |                  |                   |
        |                |                  |               |                   |  <- git merge -  |  <- git fetch -   |
        |                |      <------------- git reset ----------------       |                  |                   |
        |                |      <------------- git checkout -------------       |                  |                   |
        |                |   <- git checkout -- H.txt -     |                   |                  |                   |
        |  <- git rm -   |                  |               |                   |                  |                   |


Git Diff 输出信息含义解释：
    --- 代表源文件
    +++ 代表目标文件，一般  working area 中的文件都是作为 目标文件的
    
    - 开头的行，表示只出现在源文件中的行
    + 开头的行，表示只出现在目标文件中的行
    空格开头的行，表示在 源文件 和 目标文件 中都存在的行
    
    @@ -4,6 +4,7 @@            表示一个差异小结，含义为：源文件的 4~6 行 和 目标文件的 4~7 行 构成一个差异小结
    
    

    
    
    

