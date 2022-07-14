Netfilter Hook Infrastructure 整体图形：
                                                                Local process
                                                                 ^         |                ┌───────────┐
                                       ┌───────────┐             |         |                |  Routing  |
                                       |           |-----> input /         \---> output --->|  Decision |------
    ---> ingress ----> prerouting ---> |  Routing  |                                        └───────────┘      \
                                       | Decision  |                                                            ---> postrouting --->
                                       |           |                                                           /   
                                       │           |---------------> forward ----------------------------------
                                       └───────────┘
                                       



                                      ◂            ◂             ◂  (e.g., loopback traffic)
                                    ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓ ↙
                                    ┃                             ┃
                                   ▾┃  INPUT ○╮       ╭○ OUTPUT   ┃▴
                                    ┃   hook  │       │  hook    ┏┻┓ ▸      ▸   ▸  outbound
                               ┏━━━━┻━━━━━━━━━┿━━┓ ┏━━┿━━━━━━━━━━┫╳┣━━━━━━┳━━━┿━━━ traffic ▸
                               ┃ ▸    ▸      ▸   ┃ ┃     ▸     ▸ ┗┯┛      ┃▴  │
                               ┃                ▾┃ ┃▴             │       ┃   │
                               ┃▴            local system         │       ┃   ╰○ POSTROUTING
            inbound      ▸    ┏┻┓                                 │       ┃      hook
            traffic ▸ ━━━━━┿━━┫╳┠── routing decision    routing decision  ┃
                           │  ┗┳┛                                         ┃
               PREROUTING ○╯  ▾┃                                          ┃▴
                     hook      ┗━━━━━━━━━━━━━┿━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛
                                 ▸         ▸ │           ▸           ▸
                                             ╰○ FORWARD hook


各个相关软件的介绍：
    netfilter: 内核中实际用于流量管理的子系统
    iptables: 用于和 netfilter 交互的工具
    firewalld: 另一种工具，底层使用 iptables 来和 netfilter 交互
    nftables: 新的用于和 netfilter 交互的工具

注意点：
    1. UDP 只能通过 TPROXY 
    2. TPROXY 不能用于 output 链
    3. Netfilter 特性: 在 OUTPUT 链打标记会使相应的包重路由到 PREROUTING 链上

ISO/OSI = InternationalStandardizationOrganization/OpenSystemInterconnect = 国际标准化组织/开放式系统互联 层级:
    防火墙工作在 网络层


