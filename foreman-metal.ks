lang en_US.UTF-8
keyboard us
timezone UTC
auth --useshadow --enablemd5
selinux --permissive
firewall --enabled --ssh

repo --name=base-$releasever-$basearch    --baseurl=http://mirror.centos.org/centos/$releasever/os/$basearch
repo --name=updates-$releasever-$basearch --baseurl=http://mirror.centos.org/centos/$releasever/updates/$basearch
repo --name=extras-$releasever-$basearch  --baseurl=http://mirror.centos.org/centos/$releasever/extras/$basearch
repo --name=epel-$releasever-$basearch --mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=epel-$releasever&arch=$basearch
repo --name=live-$releasever-$basearch    --baseurl=http://www.nanotechnologies.qc.ca/propos/linux/centos-live/$basearch/live
#repo --name=a-rbel-$releasever-$basearch    --baseurl=http://rbel.frameos.org/stable/el$releasever/$basearch
#repo --name=a-wsman-$releasever-$basearch   --baseurl=http://download.opensuse.org/repositories/Openwsman/CentOS_CentOS-$releasever

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
openssh-server
openssh-clients
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

# Convenient access to epel-release
epel-release

%end

%post --nochroot
echo "Running %post --nochroot"
echo "LIVE_ROOT is $LIVE_ROOT"

for bootfile in EFI/boot/isolinux.cfg EFI/boot/grub.conf isolinux/isolinux.cfg EFI/boot/boot.conf
do
  if [ -f $LIVE_ROOT/$bootfile ]; then
    echo "Modifying $bootfile"
    sed -i -e's/ rhgb//g; s/ quiet//g'  $LIVE_ROOT/$bootfile
  fi
done

exit 0
%end

%post
echo "Running %post"
/bin/rpm --rebuilddb

# Increase the Overlay size from 512MB to 1024MB
/usr/bin/perl -pi -e 's/(^\s*dd if.*of=\/overlay.*)(512)/${1}1024/' \
  /usr/share/dracut/modules.d/90dmsquash-live/dmsquash-live-root

exit 0
%end
