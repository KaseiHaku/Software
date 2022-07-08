################################ Install： linux 软件源码安装
1. 官网下载源码包  
    mysql.tar.gz 并复制到 /usr/local/src

2. 解压拆包
    shell> cd /usr/local/src
    shell> tar -zxvf mysql.tar.gz                  # 解压、拆包

3. 查看安装文档
    shell> cd mysql
    shell> ls -al | grep Install                   # 查看有没有 Install 文件，该文件是该软件作者编写的安装文档，如果没有，那么找找其他文件，也许该作者就喜欢搞事，用其他文件名呢
    shell> vi Install                              # 查看安装文档，根据安装文档安装 

4. 查看并配置安装参数
    shell> ./configure --help                      # configure 是个可执行脚本，它有很多选项，--help 查看详细的选项列表
    shell> ./configure --prefix=/usr/local/mysql   # 配置安装参数，源码安装必须指定 --prefix 参数！，给参数指定该软件所有文件被复制到这个目录下，卸载该软件时，直接删除该目录即可，移植同理
    上述命令执行后，将生成用于编译的 MakeFile 文件
    
5. 编译源代码
    shell> make >make.log 2>&1                     # 使用默认的 makefile 文件进行编译源代码，并保存编译日志到 make.log 文件
    shell> make install >makeInstall.log 2>&1      # 安装软件，并保存安装日志到 makeInstall.log 文件，方便日后卸载的时候，查看该软件到底安装了哪些文件，安装在哪里
    shell> make clean                              # 清除编译过程中产生的临时文件
    shell> make distclean                          # 清除配置过程中产生的文件。

################################ Remove: linux 软件源码安装方式安装的软件卸载
    shell> make uninstall                          # 软解卸载，如果没有则直接删除目录即可（源码安装的方式）
    shell> make veryclean                          # 通常用于清除目标文件 .o 以及执行文件等，意思是干净的清除掉除 makefile 和源程序之外的文件。
    shell> make rl                                 # rl 是 relink 的缩写，即重新链接，常用于某个依赖的库文件发生变化时强制重新链接生成执行文件。