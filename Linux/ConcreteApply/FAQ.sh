################################ FAQ ################################




################################ FAQ ################################
# Kernel:         Linux version 6.1.0-12-amd64
# OS:             Debian 12.2.0-14
################ Question 
# debian 未登陆界面，屏幕频繁打印以下报错信息
#   ath: phy0: DMA failed to stop in 10ms AR_CR=0x00000024 AR_DIAG_SW=0x02000020 DMADBG_7=0x00008400
# 
shell> lspci -vvv      # 查看无限网卡信息如下：
Network controller: Qualcomm Atheros AR9485 Wireless Network Adapter (rev 01)
        Subsystem: AzureWave AW-NE186H
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Latency: 0, Cache Line Size: 64 bytes
        Interrupt: pin A routed to IRQ 17
        Region 0: Memory at ddc00000 (64-bit, non-prefetchable) [size=512K]
        Expansion ROM at ddc80000 [disabled] [size=64K]
        Capabilities: <access denied>
        Kernel driver in use: ath9k
        Kernel modules: ath9k
# 
# @ref { 同类型报错，及解决方案 } https://bbs.archlinux.org/viewtopic.php?id=247750
# @ref { 同类型报错，及解决方案 } https://bbs.archlinux.org/viewtopic.php?id=230745
################ Answer
# 添加 kernel parameters 
shell> sudo echo 'intel_iommu=off' >> /etc/sysctl.d/00-kh.conf
shell> sysctl --system









