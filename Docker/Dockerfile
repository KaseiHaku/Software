# Dockerfile 基本概念
# Dockerfile 中每一条指令都独立运行，并创建出一个新的镜像，所以 RUN cd /tmp 指令不会改变下一条指令的工作目录



# syntax = example.com/user/repo:tag@sha256:abcdef...
# escape = \

# 下载演示案例
# shell> cd /opt/Git/LocalRepository
# shell> git clone https://github.com/dockersamples/node-bulletin-board
# shell> cd node-bulletin-board/bulletin-board-app


# ARG 唯一可以放在 FROM 指令前面的指令，还有  parser directives 也可以放在 FROM 指令之前
# ARG 只对定义位置之后的代码生效
# ARG 间不能相互引用
# ARG 只在当前 stage 范围内有效，stage 通过 FROM 分割，FROM 之后永远是一个新的 stage
# 预定义的 ARG:
#   HTTP_PROXY  HTTPS_PROXY  FTP_PROXY  NO_PROXY
ARG  CODE_VERSION=defaultVal


# 继承 DockerHub 中的 node:current-slim 镜像
# FROM [--platform=<platform>] <image> [AS <name>]
# FROM [--platform=<platform>] <image>[:<tag>] [AS <name>]
# FROM [--platform=<platform>] <image>[@<digest>] [AS <name>]
# FROM scratch
#   表示你不以任何镜像为基础，接下来所写的指令将作为镜像第一层开始存在。
#   不以任何系统为基础，直接将可执行文件复制进镜像，
#   因为 Linux 下静态编译的程序来说，并不需要有操作系统提供运行时支持，所需的一切库都已经在可执行文件里
FROM node:current-slim


# LABEL 给 image 添加 metadata
LABEL <key>=<value> <key>=<value> <key>=<value> ...


# 设置环境变量，以供其他位置使用，调用方式 ${foo}
ENV foo /aaa
# 注意这里的 ksf 最终值为 /aaa 而不是 /bbb，因为 环境变量是直接替换整个 instruction，而不是一步步执行的
ENV foo=/bbb ksf=${foo}


# USER 
# 指定后续命令使用的 用户，这个用户必须事先建立好，否则无法切换
USER <user>[:<group>]
# WORKDIR
# 指定容器中所有后续操作的工作目录
WORKDIR /usr/src/app1


# VOLUME: 
#   声明一个 image 中的目录 是从 host 中挂载的卷，
#   如果 shell> docker run 的时候没有使用 -v 指定宿主机挂载目录，那么 VOLUME 配置的目录会自动挂载到 宿主机其他目录上，可以使用 shell> docker inspect 查看
#   该指令的作用是，防止用户在 shell> docker run 时没有指定 -v 参数，导致容器删除时，所有数据丢失
# @trap 只能指定目录
# @trap 基于 windows 的 container ，挂载目录必须是一个 空目录，或者是一个不存在的 目录，且不能再 C: 盘
# @trap 在当前语句之后的 挂载点内容的改变 都将被抛弃
# @trap 宿主机目录必须在 container 运行时指定，在 Dockerfile 中不能指定，
VOLUME /var/log /var/db



# 表示 Docker 容器在运行时监听 8080 端口，默认 tcp
# 这里只是用于描述 docker 中的 进程监听的端口，实际映射需要在 shell> docker run -p  进行指定
EXPOSE 8080/tcp
EXPOSE 8080/udp


# 在镜像中执行 npm install 命令，该命令会读取 package.json 文件，解析依赖关系，并安装依赖 
# 每个 RUN 都会创建一个新的 layer，所以最好一个 Dockerfile 只包含一个 run
# 默认的 shell 为: Linux> /bin/sh -c ...;  Windows> cmd /S /C ...
# shell form
RUN npm install             
RUN echo finish

# 存放 docker-entrypoint.sh 脚本中用到的所有文件的目录
RUN mkdir /docker-entrypoint-initdb.d       

# exec form
# 该格式最终会被解析成 JSON Array，所以有如下限制:
#   @trap 必须使用 双引号，不能用单引号
#   @trap \ 是特殊字符，必须转义，即: 使用 \\ 代表 \
RUN [ "echo", "$HOME" ]                     # @trap $HOME 不会被替换
RUN [ "/bin/bash", "-c", "echo $HOME" ]     # @trap $HOME 会被替换

# here-document
RUN <<EOT cat
#!/usr/bin/env node
console.log('use node.js to execute current script!!!');
EOT



# ADD 用于 复制 文件，目录 到 容器中的 dest 目录
# 相对路径相对于 构建 context，且不能引用 当前文件所在目录 的外部路径
# @trap dest 如果是 目录，则必须用 / 结尾
# @trap 所有文件目录的 UID 和 GID 都是 0， 除非使用 --chown 修改，如果单指定一个，那么默认两个相同
ADD [--chown=<user>:<group>] <src>... <dest>                
ADD [--chown=<user>:<group>] ["<src>",... "<dest>"]    # 适用于当 path 中包含 空格 的情况

ADD hom* /mydir/
ADD hom?.txt /mydir/
ADD arr[[]0].txt /mydir/
ADD dir /dest               # 如果 src 是目录，那么复制目录中所有的内容到 dest，包括文件系统的 元数据
ADD ./xx.tar.gz /dest       # tar 包会被解压，如果是 URL 下载的 tar 包则不会被解压

ADD http://example.com/foobar /
ADD http://example.com/foobar/ /


# 将当前 Dockerfile 所在的目录中的 package.json 复制到 /usr/src/app1 目录下
# 与 ADD 的区别是只能复制本地文件
# 相对路径相对于 构建 context，且不能引用 当前文件所在目录 的外部路径
# COPY [--chown=<user>:<group>] ["<src>",... "<dest>"]
# @trap dest 如果是 目录，则必须用 / 结尾
COPY package.json .
COPY <<-"EOT" /script.sh
  echo "hello ${FOO}"
EOT



# ONBUILD 当以当前 image 作为 base image 构建 container 时执行的 instruction
# ONBUILD 指定的命令在构建镜像时并不执行，而是在它的子镜像构建时执行
ONBUILD <INSTRUCTION>



# STOPSIGNAL  接口 kill 信号 
# 用于配置 接受什么样的 signal ，container 会退出
STOPSIGNAL 9
STOPSIGNAL 15




# SHELL 表示当前 Dockerfile 中命令默认使用的 shell 是哪个，windows 下为 SHELL ["cmd", "/S", "/C"]
SHELL ["/bin/sh", "-c"]

# CMD
# 一个 Dokcerfile 最多只能出现一次
# 指定 shell> docker run containerId cmd 中 cmd 未指定时，默认运行的命令，
# 如果 shell> docker run containerId cmd 中 cmd 存在，那么 cmd 会替换掉 Dockerfile 中默认的 CMD 命令
# shell> docker run containerId -i   那么实际运行的命令为 shell> -i
# CMD 命令最好只使用 Exec 表示法，不要用 Shell 表示法
#
# @trap 因为 exec form 会解析成 JSON Array，所以 字符串 必须使用 " 包含，不能使用单引号
# @trap 因为 ARG 是 image build-time 时才有效，而 CMD 是 image runtime 所以不能在 CMD 中使用 ARG
#       例如: CMD ["echo", "${ARG1}"]  这样是不生效的
CMD [ "ping", "start" ]

# ENTRYPOINT 
# 一个 Dokcerfile 最多只能出现一次
# shell> docker run containerId cmd 不会替换掉默认的 entrypoint
# 即： shell> docker run containerId -i  那么实际运行的命令为 shell> npm start -i 而不是像 CMD 一样整个替换掉
# ENTRYPOINT 命令最好只使用 Exec 表示法，不要用 Shell 表示法
# 当 ENTRYPOINT 和 CMD 同时存在时，docker 把 CMD 的命令拼接到 ENTRYPOINT 命令之后,
# 例如当前 Dockerfile 就是同时存在的 CMD 和 ENTRYPOINT，shell> docker run image  实际执行的是  shell> npm install ping start
# 又因为 CMD 命令可以使用 shell> docker run image cmd 中的 cmd 替换，所以最终执行结果为 shell> npm install cmd
#
# @trap 因为 exec form 会解析成 JSON Array，所以 字符串 必须使用 " 包含，不能使用单引号
# @trap 因为 exec form 不会调用 /bin/bash 等命令，所以 ["echo", "$HOME"] 这种格式不会进行变量替换，如果需要替换变量则 ["/bin/bash", "-c", "echo", "$HOME"]
# 
# 最佳实践： 
#   ENTRYPOINT ["docker-entrypoint.sh"]  并在 docker-entrypoint.sh 脚本中编写预配置代码，并将所用到的所有文件放到 /docker-entrypoint-initdb.d 目录下
ENTRYPOINT [ "npm", "install" ]

# HEALTHCHECK 
# 一个 Dokcerfile 最多只能出现一次
# 指定执行一个 cmd 来检查 container 是否健康
HEALTHCHECK [OPTIONS] CMD command


