#!/bin/bash -e
echo 'execute vps ip set in nftables!'
dig 1291114093.top aaaa +short | xargs -r -n 5 echo -n | tr ' ' ',' | xargs -rI{} nft add element ip6 tb_v2ray_ip6 vps6 {{}}
dig 1291114093.top a +short | xargs -r -n 5 echo -n | tr ' ' ',' | xargs -rI{} nft add element ip tb_v2ray vps4 {{}}
