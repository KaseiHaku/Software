################################ Basic ################################
APK download 网址:
    https://apkpure.com
    https://www.apkmirror.com


- 翻墙下载，并安装 V2rayNG
- 下载并安装 Firefox   

# 需要先关闭 MIUI optimization 才能使用，否则会报错，安装完再开回来：
#     Settings -> My device -> All specs -> 对着 MIUI version 疯狂点击，进入开发者模式
#              -> Additional settings -> Developer options -> 拉到最底下关闭 Turn on MIUI optimization
- 翻墙下载，并安装 APKMirror Installer 

# @trap 注意先检查目标手机的 Adroid 的版本，必须下载兼容目标手机版本的 Variant
# @trap 一定要下载 apk 格式的，其他格式的不行(例如: apkm)
- 翻墙下载，并安装 Google Play services。        


################################ Root ################################
Root 工具:
    Magisk         https://github.com/topjohnwu/Magisk        

################################ FAQ ################################
Adroid 安装了 CA Root Certificate 还是无法解码抓取的 https 请求，为什么?
    @ref { Network Security Configuration 官方文档 } https://developer.android.com/training/articles/security-config.html
    Adroid 7 之后，一个名为 Network Security Configuration 的安全功能出来后，
    所有使用 SDK>=24 开发的 App，都只会信任 系统证书（甚至连 系统证书 都不信任，只信任自己配的），用户自己安装的证书不会被信任了，
    所以想要完整 Charles 抓包解码，必须将 CA 证书安装到 系统证书 中，
    而操作 系统证书 需要 Root 权限，所以只能先刷机




