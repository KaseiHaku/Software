Question: gvim 每行后面出现 ^M 等标记
Cause: 当前文本文件中, 混用了 window(\r\n) linux(\n) mac(\r) 的换行格式
Solution: 替换所有换行格式为一种类型, :%s/\r\(\n\)/\1/g

