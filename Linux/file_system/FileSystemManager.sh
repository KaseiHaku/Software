################################## CentOS7 文件系统 ############################
# 当前文档标识符介绍 ##############################
file: 表示只能是文件
dir: 表示只能是目录
path: 既可以表示文件，也可以表示目录


# 路径通配符 ##############################
*                   # 代表任意多个字符
?                   # 表示任意一个字符
[0-9,a-z]           # 表示 [] 中任意一个字符
[^0-9]              # 表示不是 [] 中任意一个字符
{*.log, ?G.txt}     # 表示多个匹配模式

# 查看类 ##############################
df -ahT                         # disk free 可以查看文件挂载点，

du  -a              # 不仅列出目录，也列出文件
    -c              # 展示 total
    -h              # 人类刻度
    -d 1            # 目录深度为 1
    -s              # 仅列出 命令行参数中的 目录、文件 的整体大小
    -b              # 显示 字节数
    -B M            # 显示单位 兆
du -sh /root                    # disk usage 显示 /root 目录的大小，-s 只显示总计
du -sb /root/a.txt              # 显示文件大小，单位 Byte
du -ch --max-depth=1 /path      # 表示列出 /path 目录及其第一级子目录的大小
du -hc -d 1 -B M /path          # -d 表示执行深度；-B 表示显示 单位       





# 相关指令 #############################
mkfs -t ext4 /dev/usb                             # 格式化操作，在设备上创建文件系统


# 查找类 ###############################
pwd                                                 # 查看当前工作目录绝对路径

ls -al [path]                                       # 查看指定路径下所有文件，省略路径代表当前路径
ls -al -L /path/softlink                            # -L:当显示符号链接的文件信息时，显示符号链接所指示的对象而并非符号链接本身的信息
ls -d file1 dir2                                    # 列出指定文件或者目录， -d 表示如果是目录，也当做文件显示
ls -d -I oppositePattern path                       # 列出不符合 oppositePattern 的文件或目录，用了 -I 选项后 path 不能为 pattern 否则只会展示 pattern

file -i <file>                                      # 显示文件 MIME 类型，和文件字符编码格式
stat <file>                                         # 查看文件信息
stat -f <file>                                      # 查看磁盘信息
which mysql                                         # 只查找可执行文件，只在 $PATH 中查找
whereis command1                                    # 查找安装 command1 命令安装位置，只搜索标准位置（/bin、/sbin、/usr/bin、/usr/sbin）下的文件

locate                                              # 从 mlocate.db 索引库中查找文件，最好使用 shell> updatedb 命令更新一遍索引，确保新建文件不会遗漏

find findOpt path {expOpt (tests) action}...        # find 命令格式
find / exp1 exp2                    # and
find / exp1 -a exp2                 # and
find / !exp1 -o exp2                # not 和 or
find / exp1 , exp2                  # union
find / exp1 -print                  # 默认 action 为 print

find . ! -iregex '.*.cnf' ! -iregex '.*' -print
find . ! -iregex '.*.cnf' ! -iregex '.*' -exec command {} \;    # 注意最后的 \; 必须存在, 
                                                                # -exec 执行目录的命令目录都为 当前目录, 即: find 命令运行的目录, 可能存在竞态, 导致安全风险, 应该使用 -execdir 替代
                                                                # -execdir 执行命令的目录为 找到的文件 所在的目录
                                                                
find . ! -iregex '.*.cnf' ! -iregex '.*' -exec command {} \+    # 跟 \; 的区别为: 
                                                                # 假如 find 的结果为:
                                                                #   file1
                                                                #   file2
                                                                #   file3
                                                                # 使用 -exec command {} \; 相当于执行:
                                                                #   command file1
                                                                #   command file2
                                                                #   command file3
                                                                # 使用 -exec command {} \+ 相当于执行:
                                                                #   command file1 file2 file3
                                                            
find . -iname 'pattern' ! -type d                           # 排除目录 
find . -regextype egrep -iregex '.*[a-z].*'                 # 使用 egrep 类型的正则表达式匹配
find / -path '/proc*' -prune , -path '/var*' -prune , -path '/home*' -prune , -ipath 'pattern'      # 搜索 根目录，但是排除 /proc 目录
find / -regextype egrep -iregex '/home*|/proc*|/var*' -prune , -ipath 'pattern'                     # 同上





                                                    
# 新建类 ###############################             
mkdir -p -m 755 test1/test2/test3/test4             # 递归创建目录并设定权限
touch /home/1.txt                                   # 如果文件已存在则更新时间，否则创建空文件

# 软链接 和 硬链接 的区别
# 文件在 硬盘 中, 有一个 地址 唯一标识一个文件, 这个 地址 叫作 InodeIndex
# 文件系统中用 文件绝对路径标识一个文件, 所以这就造成了 文件系统中的多个文件, 可以同时指向 硬盘 中的一个文件. 
# 如果一个 硬盘中的文件, 同时对应 文件系统中 的多个文件, 那么在 文件系统中删除其中一个链接, 那么 硬盘 中的文件是不会被删除的, 除非所有 硬链接 都被删除
# 硬链接: 在文件系统中新建一个文件, 指向 硬盘 中的同一个文件
# 软链接: 在文件系统中 和 硬盘中都建立一个文件, 只是建立的文件的类型是 软链接, 这个文件内容中保存的是 实际文件的绝对地址
ln -s /root/aa ./bb                                 # 创建 /root/aa 的符号链接 ./bb，软连接源文件必须使用绝对路径，软连接是一个真实存在的文件，它有自己的 inodeIndex
ln -s -T /root/aa ./bb                              # -T 即: 永远把 ./bb 作为要创建的 软链接 文件名
ln -s -T -L --backup /root/aa ./bb                  # -L 如果 /root/aa 本身就是软连接，那么需要 解引用 到原始文件

ln -d ./aa.txt ./aa2.txt                            # 创建 硬链接，不允许创建目录的硬链接，硬链接必须在同一文件系统中，硬链接只是一个 inodeIndex
                                                    
                                                    
# 删除类 ###############################     
# 一个文件的数据结构包含以下字段
#   链接数：表示文件系统有多少 inodeIndex 关联到该文件
#   进程数：表示当前该文件被多少个进程打开
unlink /path                                        # 删除，使文件链接数 -1，可以删除循环软连接
rm -r xxx                                           # 删除 xxx 文件或目录
rm -f xxx                                           # 删除，不提示任何信息

# 删除恢复
# 场景一: 删除以后在进程存在删除信息
shell> lsof | grep deleted.txt            # 过滤出已经删除的文件
shell> cd /proc/${pid}/fd              # 恢复
shell> cp 1 /tmp/recover_deleted.txt                # 将 1 恢复到指定的路径


# 场景二： 删除以后进程都找不到
# 在数据删除之后，停止对当前分区做任何操作，防止inode被覆盖，可以 unmount 被删除数据所在的磁盘或是分区，如果提示 busy 可以使用 fuser 强制卸载，并断网
# 通过 dd 命令对 当前分区进行备份，防止第三方软件恢复失败导致数据丢失

                                                    
                                                    
# 操作修改类 ###########################              
cd -                                                # 切换到上一次操作的目录
cd .                                                # 当前目录
cd ..                                               # 切换到父目录


cp /source /destination/                            # 复制文件或目录，如果目标是一个目录，那复制到目标目录下，如果目标地址不存在，则复制到上一层，并重命名
cp /source /destination/newfilename                 # 复制文件，并重命名
cp -i /source /destination/                         # 复制过程中如果出现覆盖，则提示
cp -v /source /destination/                         # 显示复制过程中做了哪些操作
\cp -r /source /destination/                        # 递归复制, \ 表示不使用 alias 解析 cp 命令



mv -i /source /destination/                         # 覆盖前提示

                                                    
tar -cf xx1.tar -C ./archive xx2 xx3 ..            # 打包，以 ./archive 作为 tar 的根目录，将 ./archive/xx2，./archive/xx3 打包成 xx1.tar
tar -xf xxx.tar -C ./3                             # 拆包，-C 只当拆包到哪个目录
tar -A                                              # --concatenate 追加 tar 文件至 .tar 文件
    -p                                              # 保留文件所有信息，包括权限，owner，time 等
    -c                                              # 创建一个新的 .tar 文件
    -r                                              # 追加 file 到 .tar 文件结尾
    -x                                              # 从 .tar 文件中提取 file 到 filesystem
    -f                                              # 创建 .tar 时，指定 tar 包文件名；提取文件时，指定从哪个 tar 包中提取
    -z                                              # 打包拆包时，使用 gzip 压缩算法
    -C                                              # 拆包时，将当前 tar 包的根目录映射到指定目录下
                                                    # 打包时，将指定目录映射到 tar 包的根目录下    
    -h --dereference                                # 打包碰到 软链接 时，直接打包指向的源文件，一般不用                                                
    --hard-dereference                              # 打包碰到 硬链接 时，直接打包指向的源文件，一般不用

tar -czpf xx1.tar.gz -C ./*
tar -xzpf xx1.tar.gz -C ./unTarDir
                                                    
zip                                                 # 压缩 
unzip -d ./unzip filename                           # 将文件解压到当前目录下的 unzip 文件夹下
                                                    
chown -R oracle:dba /home/oracle                    # 更改文件夹属主为 oracle:dba
chgrp                                               # 修改文件属组
chmod -Rc MODE dir                                  # 更改文件属性
                                                    # MODE 的格式符合以下正则表达式 [ugoa]*([-+=]([rwxXst]*|[ugo]))+

                                                    
iconv -l                                             # 查看所有可用的字符编码格式
iconv -f GB2312 -t UTF-8 file1 -o file2             # 将 file1 从 GB2312 格式转化到 UTF-8 格式，并输出到 file2 中
                                                    
rename <be_replaced> <replace> ggh*.txt             # 通配符 * ? [g] 表示单个确定的字符
rename "s/.html/.jsp/" *                            # 把所有文件名中的 .html 换成 .jsp
                                                    
dirname path1                                       # 获取目录名称
                                                    
dd if=/dev/zero of=sun.txt bs=1M count=1            # 复制字节到指定文件
    if=path                                         # 代表输入文件。如果不指定if，默认就会从stdin中读取输入。
    of=path                                         # 代表输出文件。如果不指定of，默认就会将stdout作为默认输出。
    bs=1M                                           # 表示每次读入 1M ，每次输出 1M，相当于同时设置 ibs 和 obs 两个参数为 1M
    count=2                                         # 设置要读多少个 1M
                                                    
                                                    
                                                    
# 内容类 ###############################             
cat -n <file>                                       # 一次性查看全部文件内容
more <file>                                         # h 查看帮助, more 只能向下翻页不能向上,能用 less 用 less
less <file>                                         # 查看文件内容，space 下翻页， b 上翻页，q 退出当前命令，h 查看帮助，-N 查看行号
tail -f -n -10 file                                 # 读取文件最后 10 行并实时更新
head -n -10                                         # 读取整个文件，除了最后 10 行
vi <file>                                           # vi 文本编辑器





