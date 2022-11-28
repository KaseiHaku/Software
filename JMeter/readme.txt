使用步骤：
    Build Test Plan：
        thread group:
            sampler: 告诉 jmeter 发送请求到 server 并等待响应
            logical controller: 自定义 jmeter 何时发送请求
        listener: 保存 result 到 disk 中
        Test Fragments
        Timers: 计时器
        Assertions： 
        Configuration Elements
        Pre-Processor Elements
        Post-Processor Elements
        Execution order
        Scoping Rules
        Properties and Variables
        Using Variables to parameterise tests
    压测运行：
        必须以 cli-mode 运行，不能使用 GUI-mode
    压测分析：


运行:
    shell> cd $JMETER_HOME/bin
    # 各种运行模式 https://jmeter.apache.org/usermanual/get-started.html#running
    shell> ./jmeter.bat             # 命令行前台运行 GUI 模式
    shell> ./jmeterw.cmd            # 命令行后台运行 GUI 模式
    shell> ./jmeter-n.cmd           # CMD 模式
    shell> ./jmeter-n-r.cmd         # CMD 远程运行模式
    
    # 命令行模式参数 https://jmeter.apache.org/usermanual/get-started.html#non_gui
    shell> ./jmeter.sh -n                        # 非 GUI 模式
                       -t ./templates/kaseiTestPlan.jmx 
                       -l ./runResult/1/sampleResultLog.jtl 
                       -j ./runResult/1/runLog.log 
                       -e -o ./runResult/1/reportDashboardDir            # -e 压测结束后生成报告，-o 报告生成到一个空目录中，跟上一行互斥
                          
    cmd> .\jmeter.bat -n -t .\templates\kaseiTestPlan.jmx ^
                      -l .\runResult\1\sampleResultLog.jtl ^
                      -j .\runResult\1\runLog.log ^
                      -e -o .\runResult\1\reportDashboardDir           
    
