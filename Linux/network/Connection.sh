shell> ss | awk -- '/^tcp/ {map[$2]++} END { for(key in map){ print key, map[key]} } '        # 统计重复行的数量，awk map 和 ary 语法相同
