#!/bin/sh -x

cd /root/

url_image="http://ftp.freebsd.org/pub/FreeBSD/releases/VM-IMAGES/13.0-RELEASE/amd64/Latest/FreeBSD-13.0-RELEASE-amd64.raw.xz"

fetch -T 1 $url_image 

unxz -c FreeBSD-13.0-RELEASE-amd64.raw.xz | dd of=/dev/da0 bs=60M status=progress

mount /dev/da0p4 /mnt/

mv /root/getsshkey /mnt/etc/rc.d/getsshkey
chmod +x /mnt/etc/rc.d/getsshkey

sed -i '' '/^ttyu0/ s/onifconsole/on/' /mnt/etc/ttys
grep "ttyu0" /mnt/etc/ttys

sed -i '' 's/\#comconsole_speed=\".*\"/comconsole_speed=\"115200\"/g' /mnt/boot/defaults/loader.conf
grep "comconsole" /mnt/boot/defaults/loader.conf

sed -i '' 's/\#console=\".*\"/console=\"comconsole\"/g' /mnt/boot/defaults/loader.conf
grep "comconsole" /mnt/boot/defaults/loader.conf

sed -i '' 's/\#PermitRootLogin no/PermitRootLogin without-password/g' /mnt/etc/ssh/sshd_config
grep "Root" /mnt/etc/ssh/sshd_config

echo 'sshd_enable="YES"' >> /mnt/etc/rc.conf

echo 'getsshkey_enable="YES"' >> /mnt/etc/rc.conf

echo 'ifconfig_vtnet0="DHCP -rxcsum"' >> /mnt/etc/rc.conf

umount /mnt/

exit 0
