# 相关环境变量
echo $NVM_DIR                   # nvm 的安装目录
echo $NVM_BIN                   # nvm 下载的 node, npm, global installed packges 的安装目录 
echo $NVM_RC_VERSION            # .nvmrc 文件的版本
echo $NVM_INC                   # node 执行时，包含指定的目录，主要用于：当 node 要调用 c++ 库时使用

# 指定 nvm 从哪个镜像站下载 nodejs，默认为 export NVM_NODEJS_ORG_MIRROR=https://nodejs.org/dist
# 指定 nvm 从哪个镜像站下载 iojs，默认为 export NVM_IOJS_ORG_MIRROR=https://iojs.org/dist
export NVM_NODEJS_ORG_MIRROR=https://npm.taobao.org/mirrors/node

# 安装  NVM
# 下面命令下载 nvm，并执行
#       https://github.com/coreybutler/nvm-windows    windows 下的 nvm
# 该脚本将 clone nvm 库到 ~/.nvm
# 该脚本会自动往 profile 文件中添加环境变量：NVM_DIR, 
# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")" [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
shell> curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash



# 信息查看
shell> nvm ls-remote --lts                  # 查看远程可用的版本  nvm-sh
shell> nvm list avaliable                   # 同上  nvm-windows
shell> nvm ls                               # 查看所有已安装的 node 版本
shell> nvm which 5.0                        # 查看指定版本的 node 安装路径
shell> nvm current                          # 查看当前 shell 使用的 node 版本
shell> nvm alias                            # 查看所有的版本的别名
shell> nvm alias default                    # 查看默认版本，第一次安装的 node 版本
shell> nvm alias default node               # 从新设置默认 node 版本




# 安装指定的 node 版本
shell> nvm install -s --lts 6.14.4                              # 首次安装的 node 版本将成为默认的 node 版本， 
                                                                # -s 表示如果能找到 .nvmrc 那么就使用该文件中的配置
                                                                # --lts 只安装长期支持版本
                                                                
shell> nvm reinstall-packages <version>                         # 重装所有指定 node 版本，全局安装的 npm 包 


# 在当前 shell 使用指定的 node 版本
shell> nvm use <tab>                                            # 如果 .nvmrc 存在，那么使用 .nvmrc 中配置的
shell> nvm run 10.24.0 app.js                                   # 使用指定的 node 版本执行 app.js 
shell> nvm exec 10.24.0 "node app.js"                           # 使用指定的 node 版本，执行命令 "node app.js"




# 在项目里面配置使用的 node 版本
# 创建 xxx/ProjectRoot/.nvmrc







