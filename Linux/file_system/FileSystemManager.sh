################################## CentOS7 文件系统 ############################
# 路径通配符 ##############################
*                   # 代表任意多个字符
?                   # 表示任意一个字符
[0-9,a-z]           # 表示 [] 中任意一个字符
[^0-9]              # 表示不是 [] 中任意一个字符
{*.log, ?G.txt}     # 表示多个匹配模式

# 查看类 ##############################
du -sh /root        # 显示 /root 目录的大小，-s 只显示总计
du -sb /root/a.txt  # 显示文件大小，单位 Byte
du -ch --max-depth=1 /path       # 表示列出 /path 目录及其第一级子目录的大小

# 相关指令 #############################
mkfs -t ext4 /dev/usb                             # 格式化操作，在设备上创建文件系统


# 查找类 ###############################
pwd                                                 # 查看当前工作目录绝对路径
ls -al [path]                                       # 查看指定路径下所有文件，省略路径代表当前路径
file -i <file>                                      # 显示文件 MIME 类型，和文件字符编码格式
stat <file>                                         # 查看文件信息
stat -f <file>                                      # 查看磁盘信息
which mysql                                         # 只查找可执行文件，基本只在 $PATH 中查找
whereis command1                                    # 查找安装 command1 命令安装位置，比 which 搜索范围广

locate                                              # 从索引库中查找文件，最好使用 updatedb 命令更新一遍索引，确保新建文件不会遗漏

find findOpt path expOpt (tests) action             # find 命令格式
find / exp1 exp2                    # and
find / exp1,exp2                    # union
find / !exp1 -o exp2                # not 和 or
find / exp1 -print                  # 默认 action 为 print

find . ! -iregex '.*.cnf' ! -iregex '.*' -print
find . ! -iregex '.*.cnf' ! -iregex '.*' -exec command {} \;  # 注意最后的 \;

find -regextype egrep . -iregex 'regex'              # 使用 egrep 类型的正则表达式匹配






                                                    
# 新建类 ###############################             
mkdir -p -m 755 test1/test2/test3/test4             # 递归创建目录并设定权限
touch /home/1.txt                                   # 如果文件已存在则更新时间，否则创建空文件
ln -s /root/aa ./bb                                 # 创建 ./aa 的符号链接 ./bb，软连接源文件必须使用绝对路径，软连接是一个真是存在的文件，它有自己的 inodeIndex
ln -d ./aa.txt ./aa2.txt                            # 创建 硬链接，不允许创建目录的硬链接，硬链接必须在同一文件系统中，硬链接只是一个 inodeIndex
                                                    
                                                    
# 删除类 ###############################     
# 一个文件的数据结构包含以下字段
#   链接数：表示文件系统有多少 inodeIndex 关联到该文件
#   进程数：表示当前该文件被多少个进程打开
unlink /path                                        # 删除，使文件链接数 -1，可以删除循环软连接
rm -r xxx                                           # 删除 xxx 文件或目录
rm -f xxx                                           # 删除，不提示任何信息

                                                    
                                                    
# 操作修改类 ###########################              
cd -                                                # 切换到上一次操作的目录
cd .                                                # 当前目录
cd ..                                               # 切换到父目录


cp /source /destination/                            # 复制文件或目录，如果目标是一个目录，那复制到目标目录下，如果目标地址不存在，则复制到上一层，并重命名
cp /source /destination/newfilename                 # 复制文件，并重命名
cp -i /source /destination/                         # 复制过程中如果出现覆盖，则提示
cp -v /source /destination/                         # 显示复制过程中做了哪些操作
cp -r /source /destination/                         # 递归复制


mv -i /source /destination/                         # 覆盖前提示

                                                    
tar -cf xx1.tar xx2 xx3 ..                          # xx2，xx3打包成xx1
tar -xf xxx.tar -C ./3                              # 拆包，-C 只当拆包到哪个目录
                                                    
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
cat <file>                                          # 一次性查看全部文件内容
less <file>                                         # 查看文件内容，space 下翻页， b 上翻页，q 退出当前命令，h 查看帮助
tail -10 -f file                                    # 读取文件最后 10 行并实时更新
head -10                                            # 读取文件前 10 行
vi <file>                                           # vi 文本编辑器





