shell> cat <<-'EOF' >> /etc/environment
# @kasei fcitx5
INPUT_METHOD=fcitx
#GTK_IM_MODULE=fcitx
#QT_IM_MODULE=fcitx
#SDL_IM_MODULE=fcitx
GLFW_IM_MODULE=ibus
XMODIFIERS='@im=fcitx'

# @kasei
LC_ALL=en_US.UTF-8
EOF
