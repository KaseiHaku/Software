Taint: 污点

    CURD:
        shell> kubectl describe nodes xxx  | grep -i taint      # 查看污点
        shell> kubectl taint nodes xxx key=val:effect           # 添加污点
        shell> kubectl taint nodes xxx key-                     # 删除污点




Toleration: 容忍




