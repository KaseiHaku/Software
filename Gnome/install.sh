######################################### 安装 GNOME Desktop #######################################
yum grouplist                                   # 查看所有可安装的软件组
yum -y groupinstall "GNOME Desktop" "Graphical Administration Tools" 			# 安装 GNOME Desktop 软件组

#################### 创建桌面软件的快捷方式
cd /usr/share/applications                      
ls |grep chrome                                 # 找到 xxx.desktop 文件
cp xxx.desktop ~/Desktop                        # 直接 copy 该文件到桌面即可


#################### 修改桌面图标大小
gsettings range org.gnome.nautilus.icon-view default-zoom-level                 # 查看所有图标大小值
gsettings set org.gnome.nautilus.icon-view default-zoom-level small             # 设置图标大小值为 small



