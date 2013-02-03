#! /bin/sh
sudo /usr/bin/livecd-creator --tmpdir=/tmp --cache /var/cache/live --verbose \
  --config foreman-metal.ks --title="Foreman Metal" --product "Metal" \
  -f foreman-metal --compression-type=gzip

if [ $? -eq 0 ]; then
  sudo /usr/bin/livecd-iso-to-pxeboot foreman-metal.iso
fi
