lang en_US.UTF-8
keyboard us
timezone UTC
auth --useshadow --enablemd5
selinux --permissive
firewall --enabled

repo --name=base    --baseurl=http://mirror.centos.org/centos/6/os/$basearch
repo --name=updates --baseurl=http://mirror.centos.org/centos/6/updates/$basearch
repo --name=extras  --baseurl=http://mirror.centos.org/centos/6/extras/$basearch
repo --name=epel    --mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=epel-6&arch=x86_64
repo --name=live    --baseurl=http://www.nanotechnologies.qc.ca/propos/linux/centos-live/$basearch/live
#repo --name=a-rbel    --baseurl=http://rbel.frameos.org/stable/el6/$basearch
#repo --name=a-wsman   --baseurl=http://download.opensuse.org/repositories/Openwsman/CentOS_CentOS-6

skipx

%packages --excludedocs --nobase
#@core
syslinux
passwd
rootfiles
dhclient
OpenIPMI-tools
OpenIPMI
wget
dmidecode
puppet
curl
yum
system-config-firewall-base
-*-firmware
-b43-openfwwf
-cyrus-sasl
-postfix
-rsyslog
-sudo
-curl

# install later if needed
-perl

# or root won't mount:
libsysfs
device-mapper
dracut

# for consistent device naming
biosdevname

%end

%post --nochroot
for bootfile in EFI/boot/isolinux.cfg EFI/boot/grub.conf isolinux/isolinux.cfg EFI/boot/boot.conf
do
  sed -i -e's/ rhgb//g; s/ quiet//g'  $LIVE_ROOT/$bootfile
done
%end

%post
rpm --rebuilddb

exit 0
%end
