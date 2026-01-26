# Linux 图形界面协议分两种: 
#     X11                # 老协议，淘汰中
#     Wayland            # 新协议
#     XWayland           # 接收 X11 并转换成 Wayland 协议给操作系统底层
# Fcitx 设置:
#     - Start fcitx5 by go to "System settings" -> "Virtual keyboard" -> Select Fcitx 5
#     - Run chromium/electron application with --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime
shell> cat <<-'EOF' >> /etc/environment
# @kasei fcitx5
INPUT_METHOD=fcitx
# 给 GTK 应用设置输入法，底层使用 X11 协议
GTK_IM_MODULE=fcitx
# 给 QT 应用设置输入法，底层使用 X11 协议
QT_IM_MODULE=fcitx
# 给 SDL 应用设置输入法，底层使用 X11 协议
SDL_IM_MODULE=fcitx
# 给 GLFW 应用设置输入法，底层使用 X11 协议
GLFW_IM_MODULE=ibus
# 给使用 Wayland 协议的应用设置输入法
XMODIFIERS='@im=fcitx'

# @kasei
LC_ALL=en_US.UTF-8
EOF
