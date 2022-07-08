Manual:
    shell> man 5 systemd.unit
    
Related Path:
    System Unit Search Path:    shell> systemctl [--system] daemon-reload 
        /etc/systemd/system                 # 系统级 服务单元 存放位置
        /usr/lib/systemd/system             # 系统级 三方包 服务单元 配置路径
        /usr/local/lib/systemd/system       # 系统级 管理员创建的 本地 服务单元 存放位置
        
        
    User Unit Search Path:      shell> systemctl --user daemon-reload
        /etc/systemd/user                   # 用户级 服务单元 存放位置
        /usr/lib/systemd/user               # 用户级 三方包 服务单元 配置路径
        /usr/local/lib/systemd/user         # 用户级 管理员创建的 本地 服务单元 存放位置
        


服务文件配置：
# @trap 注释不能接在行末，会导致读取失败，当前文件是为了书写方便，实际不能这么写注释

[Unit]
# 该 section 主要是针对当前 服务单元 进行一些配置
Description=
Documentation=
Wants=
Requires=
Requisite=
BindsTo=
PartOf=
Upholds=
Conflicts=
Before=, After=
OnFailure=
OnSuccess=
PropagatesReloadTo=, ReloadPropagatedFrom=
PropagatesStopTo=, StopPropagatedFrom=
JoinsNamespaceOf=

ConditionArchitecture=          # 
AssertArchitecture=             # 和 condition 一样，不过任何 不满足的 assert 会直接导致 服务启动失败

[Install]
# 该 section 跟 systemd 没有任何关系，主要用于 shell> systemctl enable  和 shell> systemctl disable
Alias=
WantedBy=
RequiredBy=
Also=
DefaultInstance=

