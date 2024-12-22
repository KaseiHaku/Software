项目地址 {
    https://github.com/fatedier/frp
}


下载: {
    Win x86_64:             frp_0.61.1_windows_amd64.zip
    Linux x86_64:           frp_0.61.1_linux_amd64.tar.gz
}


TCP 流量转发(frps -> frpc): {

    frps: {
        frps.toml: {
            bindPort = 7000
        }    

        启动命令:
            shell> nohup ./frps -c ./frps.toml &         # Linux 下命令

    }

    frpc: {
        frpc.toml: {
            serverAddr = 11.64.4.199
            serverPort = 7000


            [[proxies]]
            name = "web"
            type = tcp
            localIP = "127.0.0.1"
            localPort = 9201
            remotePort = 9999
        } 

        启动命令:
            shell> .\frpc.exe -c .\frpc.toml         # Win 下命令

    }

}






