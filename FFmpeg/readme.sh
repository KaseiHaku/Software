################################ Concept ########################
# @doc {official} https://www.ffmpeg.org/documentation.html
# @doc {优秀文档} https://juejin.cn/post/7064869914347044878
# 
# 视频转换操作:
#     transcoding(转码)：将一个 视频流 或者 音频流 从一个编码格式转换到另一个格式
#     transmuxing(转 封装/容器 格式)：将视频的从某一格式（容器）转换成另外一个
#     transrating(转码率): 每秒传输的比特位数，单位: bps(bit per second)
#     transsizing(转分辨率): 480p 720p(1280*720) 1080p(1920*1080=2k) 2160p(3840*2160=4K)       指 宽:高=16:9 的情况下，高度对应的像素个数
# 
# 
# container: 容器/封装格式 - 整合 视频/音频/字幕 等内容的地方，例如: .webm .mp4 .mkv
# stream type: 流类型
#     video            # 视频
#     audio            # 音频
#     subtitle         # 字幕
#     attachment
#     data
# 
# 
################ FFmpeg 相关组件
# Demuxers: demultiplexers 解复用器，deinterlacing(反交织)
#     从一个 input 中提取 elementary(基础) stream, 例如: video stream, audio stream 等
#     stream 为一系列 packets 的集合
# Decoder: 解码器
#     将 stream(packet) 解码为 raw frame(原始帧)
#     video stream -> pixels
#     audio stream -> PCM(Pulse Code Modulation/脉冲编码调制)
# Filtergraph: 过滤器图
#     -filter: simple
#         绑定一个 output stream，并使用 yadif 进行格式转换，然后使用 scale 进行大小转换
#     -filter_complex: complex
#         不绑定任何具体的 stream, 
#         可能有 0-n 个 input，可以从 decoder 或其他 complex filtergraph's output 接收数据
#         可能有 0-n 个 output, 然后 喂给 encoder 或其他 complex filtergraph's input
# Encoder: 编码器
#     接收 raw frame ，并重新编码为 stream(packet)
#     执行 编码，压缩 等操作
#     video/audio encoder 可以从 filtergraph 的 output 获取 input data
#     subtitle encoder 只能从 decoder output 获取 input data,因为不支持对 subtitle 进行 filtering
#     每个 encoder 都和某个 muxer 的 output elementary stream 相关联，并将 output 发送给该 muxer
# Muxers: multiplexers 复用器
#     从 encoder 的 output 获取数据（转码操作）
#     直接从 demuxer 获取数据（流复制）
#     然后将这些 stream interleave(交织) 最终输出为 file，pipe stream 等
#     
# 
# 
################ FFmpeg Options
# options:
#    # 除了 global option(必须放在选项最前面) 以外，所有命令行选项都只对最近的 input(-i) 和 output 生效
#    # input 和 output 不能 mix(混合)， 所以只能是 input0 input1 input2 output0 output1
# 
#    -map 2:4       # 指定从哪个 stream input 输出到哪个 output 中， 2:4 = 表示第 3 个 input 的第 5 个 stream
#                   # 命令行中只能通过 indices(0-based) 来选择 input 和 stream, 格式：input:stream = 2:4    表示第 3 个 input 的第 5 个 stream
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
              -dash 1                                            # 是否创建符合 WebM DASH 规范的 webm 文件; shell 中的 Boolean 值: true/false, 1/0
              video_1920x1080_1500k.webm                         # 处理后的文件名


shell> ffmpeg -i bunny_1080p_60fps.mp4 -c:v libvpx-vp9 -s 1280x720 -b:v 1500k -keyint_min 150 -g 150 -an -f webm -dash 1 video_1280x720_1500k.webm        # 从 mp4 容器中提取 视频 并重新封装为 webm 格式
shell> ffmpeg -i bunny_1080p_60fps.mp4 -c:a libvorbis -b:a 128k -vn -f webm -dash 1 audio_128k.webm                                                       # 从 mp4 容器中提取 音频 并重新封装为 webm 格式

# webm 转 MPEG-DASH 
shell> ffmpeg -n \                                                         # 全局配置结束;
              -f webm_dash_manifest -i video_160x90_250k.webm \            # 不同 码率 和 分辨率 的视频文件
              -f webm_dash_manifest -i video_320x180_500k.webm \
              -f webm_dash_manifest -i video_640x360_750k.webm \
              -f webm_dash_manifest -i video_640x360_1000k.webm \
              -f webm_dash_manifest -i video_1280x720_500k.webm \
              -f webm_dash_manifest -i audio_128k.webm \                   # 音频文件; 
              # 输入配置结束;
              -c copy -map 0 -map 1 -map 2 -map 3 -map 4 -map 5 \
              -f webm_dash_manifest 
              -adaptation_sets "id=0,streams=0,1,2,3,4 id=1,streams=5" \        # 表示 stream(流) 0,1,2,3,4 分为一组，5 单独分为一组
              manifest.mpd



