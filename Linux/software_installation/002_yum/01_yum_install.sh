# CentOS 7 yum 安装=
#1. 下载所需的软件包
    python-urlgrabber-3.10-8.el7.noarch.rpm
	python-iniparse-0.4-9.el7.noarch.rpm
	yum-plugin-fastestmirror-1.1.31-40.el7.noarch.rpm
	yum-metadata-parser-1.1.4-10.el7.x86_64.rpm
	yum-3.4.3-150.el7.centos.noarch.rpm	
	
#2. 安装以上所有软件包
    shell> rpm -iv python-urlgrabber-3.10-8.el7.noarch.rpm  # 安装软件包
    
    
#3. 下载签名文件
    shell> curl -O https://domain/RPM-GPG-KEY-CentOS-7										#签名文件
    
#4. 导入签名文件
    shell> ll /etc/pki/rpm-gpg/         # 查看现有 GPG key 文件
    shell> rpm --import RPM-GPG-KEY-CentOS-7					#导入签名文件

#5. yum 配置，见 02_yum_settings 配置手册
