Session 配置:
    什么是 Session? 一次文件对比就是一个 session
    Session -> Session Settings -> Comparison
        -> [不勾选] Compare file size
        -> [不勾选] Compare timestamps
        -> [√] Compare contents 
            -> [单选] Rules-based comparison
            -> [勾选] Skip if quick tests indicate files are the same

文件编码格式不同时，对比：
    Tools -> File Formats -> Conversion -> Encoding: 选择合适的字符集 -> Save

Rules-based comparison Rule 配置：
    不同的 Compare 有不同的 Session Settings 自行摸索
    Fold Compare:
        Session -> Session Settings ->
    Text Compare:
        Session -> Session Settings ->

对比文件夹下的所有文件:
    Actions -> Compare Contents... 
        -> CRC comparision: Cyclic Redundancy Code，意为循环冗余码校验
        -> Binaray comparision: 二进制比较
        -> Rules-based comparision：根据规则进行对比
 
 
