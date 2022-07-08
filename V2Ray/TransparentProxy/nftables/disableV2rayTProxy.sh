#!/bin/bash -e

nft flush ruleset

ip rule del fwmark 2 pref 1024 table 100
ip route del local 0.0.0.0/0 table 100 dev lo onlink

ip -6 rule del fwmark 2 pref 1024 table 100
ip -6 route del local ::/0 table 100 dev lo onlink
