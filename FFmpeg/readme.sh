################################ Help ########################
ffmpeg -h
ffmpeg -h long
ffmpeg -h full
ffmpeg -h type=name        # name=decoder/encoder/demuxer/muxer/filter/bsf/protocol
ffmpeg -formats            # 指定类别的帮助
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



################################ Command ########################
ffmpeg [options] \
       [[infile options] -i infile] \
       {[outfile options] outfile}...






