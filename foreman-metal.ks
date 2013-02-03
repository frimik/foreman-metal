lang en_US.UTF-8
keyboard us
timezone UTC
auth --useshadow --enablemd5
selinux --permissive
firewall --disabled

repo --name=base    --baseurl=http://mirror.centos.org/centos/6/os/$basearch
repo --name=updates --baseurl=http://mirror.centos.org/centos/6/updates/$basearch
repo --name=extras  --baseurl=http://mirror.centos.org/centos/6/extras/$basearch
repo --name=epel    --mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=epel-6&arch=x86_64
repo --name=live    --baseurl=http://www.nanotechnologies.qc.ca/propos/linux/centos-live/$basearch/live
repo --name=metal   --baseurl=http://static.tmtowtdi.se/yum/foreman-metal/6/x86_64
#repo --name=a-rbel    --baseurl=http://rbel.frameos.org/stable/el6/$basearch
#repo --name=a-wsman   --baseurl=http://download.opensuse.org/repositories/Openwsman/CentOS_CentOS-6

%packages
bash
kernel
syslinux
passwd
chkconfig
authconfig
rootfiles
dhclient
comps-extras
vim-enhanced
openssh-clients
openssh-server
OpenIPMI-tools
OpenIPMI
rpcbind
nfs-utils
wget
dmidecode
libxml2
curl
git
ruby
puppet
parted
yum
foreman-metalbuild
system-config-firewall-base

# or root won't mount:
libsysfs
%end

%post
rpm --rebuilddb

exit 0
%end
