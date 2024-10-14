################################ Concept ########################
# @doc {优秀文档} https://juejin.cn/post/7064869914347044878
# 
# codec: 编解码 - 压缩数据
# container: 容器/封装格式 - 整合 视频/音频/字幕 等内容的地方，例如: .webm .mp4 .mkv
# 
# 视频转换操作:
#     transcoding(转码)：将一个 视频流 或者 音频流 从一个编码格式转换到另一个格式
#     transmuxing(转封装)：将视频的从某一格式（容器）转换成另外一个
#     transrating(转码率): 每秒传输的比特位数，单位: bps(bit per second)
#     transsizing(转分辨率): 480p 1080p 2160p(4K)       指 宽:高=16:9 的情况下，高度对应的像素个数
#
#


################################ Help ########################
shell> ffmpeg -h
shell> ffmpeg -h long
shell> ffmpeg -h full
shell> ffmpeg -h type=name        # name=decoder/encoder/demuxer/muxer/filter/bsf/protocol
shell> ffmpeg -formats            # 指定类别的帮助
# Print help / information / capabilities:
        -L                  show license
        -h topic            show help
        -? topic            show help
        -help topic         show help
        --help topic        show help
        -version            show version
        -buildconf          show build configuration
        -formats            show available formats
        -muxers             show available muxers
        -demuxers           show available demuxers
        -devices            show available devices
        -codecs             show available codecs
        -decoders           show available decoders
        -encoders           show available encoders
        -bsfs               show available bit stream filters
        -protocols          show available protocols
        -filters            show available filters
        -pix_fmts           show available pixel formats
        -layouts            show standard channel layouts
        -sample_fmts        show available audio sample formats
        -dispositions       show available stream dispositions
        -colors             show available color names
        -sources device     list sources of the input device
        -sinks device       list sinks of the output device
        -hwaccels           show available HW acceleration methods


shell> ffmpeg -h full | grep -B4 -A2 -n --color=auto -i '^\-f '            # 常用查询帮助格式


################################ Command ########################
#ffmpeg [options] \
#       [[infile options] -i infile] \
#       {[outfile options] outfile}...

# mp4 转 webm
shell> ffmpeg -n \                                               # 全局配置结束; -n: 不覆盖已存在的文件
              -i bunny_1080p_60fps.mp4 \                         # 输入配置结束; 
              
              -c:v libvpx-vp9                                    # video 编码
              -s 1920x1080                                       # 分辨率
              -b:v 1500k                                         # video 比特率
              -keyint_min 150 
              -g 150 
              -an                                                # 关闭 audio
              -f webm                                            # 输出的封装格式
              -dash 1 
              video_1920x1080_1500k.webm                         # 处理后的文件名


# webm 转 MPEG-DASH 
shell> ffmpeg -n \                                                         # 全局配置结束;
              -f webm_dash_manifest -i video_1920x1080_1500k.webm \        # 输入配置结束;
              -c copy -map 0 -map 1 -map 2 -map 3 -map 4 -map 5 \
              -f webm_dash_manifest -adaptation_sets "id=0,streams=0,1,2,3,4 id=1,streams=5" \
               manifest.mpd



