CipherSuit(加密算法套件): 
    Kx: 1 个 key exchange(密钥交换)算法
    Au: 1 个 authentication (认证，数字签名)算法 
    Enc: 1 个 encryption(加密)算法
    Mac: 1 个 message authentication code (消息认证码 简称MAC，消息摘要)算法 

    CipherString: 一个 label，代表具有该 label 的所有 CipherSuit
        @trap 不是 加密套件 的名称，具体查看 shell> man ciphers; 常用 cipher string = [ALL，HIGH，NULL，TLSv1.2]
        :   代表 或，用于 多个 CipherString 的组合
        +   中缀， 表示 且，用于 CipherString 组合
        
        -   从列表中删除 当前 CipherString，但是后续可以重新加入
        !   从列表中永久删除 当前 CipherString，即使后续重新加入也没用
        +   前缀 表示当前 CipherString 移到列表最后
        
        
        shell> openssl ciphers -v 'TLSv1.2+ECDH+ECDSA+AESGCM'          # 检查当前格式 匹配 的所有加密套件

推荐加密套件：
    TLS_AES_128_GCM_SHA256
    TLS_AES_256_GCM_SHA384
    TLS_CHACHA20_POLY1305_SHA256

对称加密：
    存在一个密钥，该密钥同时用于加密和解密
    
不对称加密：
    存在两个密钥：公钥 和 私钥
    通过私钥可以计算出公钥，反之则不行
    公钥加密的数据，只有私钥能解
    私钥加密的数据，只有公钥能解

数据签名：
    对文件进行数据签名的整体流程
        1. 使用 哈希算法 对文件内容求 哈希值
        2. 对得到的 哈希值 使用 私钥 加密得到 数据签名
        3. 将 数据签名 和 文件一起发送给接收者
        4. 接收者使用跟发送者相同的 哈希算法 对文件内容求 哈希值，得到 哈希值A
        5. 接收者使用发送者的 公钥 对 数据签名 进行解密 得到 哈希值B，如果能解开就证明文件是 发送者发送的
        6. 对比 哈希值A 和 B，如果相同，则证明没有被修改过
        
        
