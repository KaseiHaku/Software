# 相关文件
    /etc/docker/daemon.json         # dockerd 配置文件
    ~/.docker/config.json           # docker client 配置文件，linux windows 通用


# DockerHub 中 tag 的区别
    Simple Tag: 指向唯一 image，推荐使用
    Sharde Tag: 指向一个 image，但是这个指向会随着时间的推移，会指向别的 image



# WSL 2 安装 docker desktop 对应的 /var/lib/docker 目录
    \\wsl.localhost\docker-desktop-data\data\docker\volumes\127517c94e73e80e97102a8549739182fab8c444436ccc48521efabc421eee6e\_data


# Concept
    docker -[call]-> dockerd -[invoke]-> containerd -[call]-> runc    完成容器运行
    docker: 用户 Cli 工具
    dockerd: 接受 docker 命令的 deamon 守护进程, CLI 命令为: shell> docker --help
    containerd: 底层实际用来管理 container/image 的 deamon, CLI 命令为: shell> ctr --help
    runc: 负责 容器运行 及 搜集运行数据
