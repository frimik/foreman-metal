Name:           foreman-metal
Version:        0.1
Release:        1%{?dist}
Summary:        Foreman Bare Metal

Group:          System Environment/Foreman
License:        GPLv3
URL:            http://www.tmtowtdi.se/
Source0:        foreman-metal.ks
BuildRoot:      %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)

BuildArch:      noarch
BuildRequires:  foreman-metalbuild
BuildRequires:  livecd-tools
BuildRequires:  sudo

%description
Foreman Bare Metal

%prep
%setup -c -n %{name}-%{version} -T
mkdir -p %{_builddir}/%{name}-%{version}
cd %{_builddir}/%{name}-%{version}
cp %SOURCE0 foreman-metal.ks


%build
sudo /bin/mknod -m0660 /dev/loop0 b 7 0
sudo /bin/mknod -m0660 /dev/loop1 b 7 1
sudo /bin/mknod -m0660 /dev/loop2 b 7 2
sudo /bin/mknod -m0600 /dev/loop-control c 10 237

sudo /usr/bin/livecd-creator --tmpdir=/tmp --cache /var/cache/live \
  --verbose --config foreman-metal.ks \
  --title="Foreman Metal" --product "Metal" \
  -f foreman-metal --compression-type=gzip

sudo /usr/bin/livecd-iso-to-pxeboot foreman-metal.iso

%install
rm -rf %{buildroot}
mkdir -p %{buildroot}/usr/share/foreman-metal
install -m644 foreman-metal.iso \
  %{buildroot}%{_datadir}/foreman-metal/foreman-metal.iso
cp -pRv tftpboot %{buildroot}%{_datadir}/foreman-metal/


%clean
rm -rf %{buildroot}


%files
%doc
%{_datadir}/foreman-metal

%changelog
* Sun Feb 03 2013 Mikael Fridh <frimik@gmail.com> - 0.1-1
- new version

