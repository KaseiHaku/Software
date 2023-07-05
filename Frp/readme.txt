项目地址 {
    https://github.com/fatedier/frp
}


下载: {
    Win x86_64:             frp_0.50.0_windows_amd64.zip
    Linux x86_64:           frp_0.50.0_linux_amd64.tar.gz
}


TCP 流量转发(frps -> frpc): {

    frps: {
        frps.ini: {
            [common]
            bind_port = 7000
        }    

        启动命令:
            shell> nohup ./frps -c ./frps.ini &         # Linux 下命令

    }

    frpc: {
        frpc.ini: {
            [common]
            server_addr = 11.64.4.199
            server_port = 7000


            [web]
            type = tcp
            local_port = 9201
            remote_port = 9999
        } 

        启动命令:
            shell> .\frpc.exe -c .\frpc.ini         # Win 下命令

    }

}






