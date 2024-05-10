################################ Debugging Node.js ################################
# @doc {官方文档} https://nodejs.org/en/learn/getting-started/debugging
#
#
#
################################ Debugging Node.js with Chrome DevTools ################################
shell> node --inspect-brk index.js        # 以 debug 模式运行 node
shell> chrome 地址栏输入: chrome://inspect 
shell> 勾选 "Discover network targets", 并点击右边的 Configure... 按钮
shell> 检查弹出框中存在 第一步 启动的 debug server 的 ip 和 端口
shell> 点击 "Open dedicated DevTools for Node" 或者 kill debug server 然后再重启，chrome 会自动连接的


################################ Debugging with IDEA ################################
shell> node --inspect-brk node_modules/vite/bin/vite.js build -d -c ./bpm-starter/bpm-starter-basic/vite.config.js        # debug 模式启动

# 方式一：
shell> 新增一个 "Attach to Node.js/Chrome" 类型的 "Run/Debug Configuration"，并配置好 host(localhost) 和 port(9229)，然后运行就会连接到 debug server 了

# 方式二:
shell> 上述命令运行后会输出 ws://127.0.0.1:9229/b5b82e77-5036-49ee-a2dd-fb32b991813c 的连接地址，
       控制台直接点击该链接，IDEA 会自动创建 "Attach to Node.js/Chrome" 类型的 debug 窗口
       
# 方式三: 
shell> Run/Debug Configuration 新增一个 Node 类型的
shell> 配置好要运行的 .js 文件，点击 debug 按钮运行即可











