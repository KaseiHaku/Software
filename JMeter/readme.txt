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
