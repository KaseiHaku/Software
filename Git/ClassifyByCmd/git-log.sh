# git log [<options>] [<revision range>] [[--] <path>…]
shell> git log 

                ##### options
                --follow -- file                # git log 跟踪重命名后的文件改动，只对单个文件生效
                --decorate=full                 # 打印 ref(引用) 信息 和 格式
                --decorate-refs=<pattern>       # 只打印符合 pattern  的 ref 信息
                --source                        # 打印 commit 提交时，命令行中给定的 ref 信息
                --mailmap                       # 使用 mailmap 文件映射 author, commiter, email 到 真实名称 和 真实邮箱
                --full-diff                     # 
                --log-size                      # 打印 commit message 的字节长度
                -L<start>,<end>:<file>          # 跟踪指定范围内的改动
                # Commit Limiting   提交限制
                
                # History Simplification
                
                # Commit Ordering 提交排序
                --date-order                    # 父提交在子提交前面，but otherwise(除此之外)，根据 commit date 来排序
                --author-date-order             # 父提交在子提交前面，but otherwise(除此之外)，根据 author date 来排序
                --topo-order                    # 默认选项，父提交在子提交前面，but otherwise(除此之外)，避免提交在不同的 历史提交线上出现，优先显示同一提交线上的提交，
                --reverse                       # 反向排序
                
                # Object Traversal  对象遍历
                
                # Commit Formatting 提交格式化
                --pretty='tformat:%h %an %as %s %d'
                --format='tformat:%h %an %as %s %d'
                    # %h            # abbreviated commit hash 
                    
                    # %an           # author name
                    # %ae           # author email
                    
                    # %aI           # author date，严格的 ISO 8601格式
                    # %as           # author date，YYYY-MM-DD
                    
                    # %s            # 仅打印标题 subject，即: shell> git commit -m 'msg'; 中的 msg
                    # %b            # 仅打印主体 body，
                    # %B            # 打印 subject 和 body
                    
                    # %d            # 分支引用名称
                
                # PRETTY FORMATS    输出格式配置
                
                # DIFF FORMATTING   文件对比格式配置
                
                # Generating patch text with -p  生成补丁配置
                
                # Combined diff format  组合文件对比格式配置
                
                
                ##### revision range
                origin..HEAD                    # 只显示指定 commit 之间的改动
                
                ##### path
                -- file                         # 只跟踪指定文件的改动
                
                
