#!/bin/bash

targetdir=rootfs
distro=etch

apt-get install qemu-user-static debootstrap binfmt-support

mkdir $targetdir/usr/sbin/debootstrap --arch=arm --foreign $distro $targetdir

cp /usr/bin/qemu-arm-static $targetdir/usr/bin/
cp /etc/resolv.conf $targetdir/etc

/usr/sbin/chroot $targetdir


distro=etch
export LANG=C

/debootstrap/debootstrap --second-stage

cat <<EOT > /etc/apt/sources.list
# deb http://archive.debian.org/debian/ $distro main
deb http://archive.debian.org/debian/ $distro main non-free contrib
deb http://archive.debian.org/debian-security/ $distro/updates main non-free contrib
deb-src http://archive.debian.org/debian/ $distro main non-free contrib
deb-src http://archive.debian.org/debian-security/ $distro/updates main non-freecontrib
EOT

apt-get update

export PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin

mount proc /proc -t proc
mount devpts /dev/pts -t devpts

apt-get install locales dialog

dpkg-reconfigure locales

apt-get install telnetd ntpdate mc ncurses-dev gcc make patch irda-utils ppp

echo <<EOT >> /etc/network/interfaces
allow-hotplug eth0
iface eth0 inet static
	address 192.168.1.254
	netmask 255.255.255.248
	gateway 192.168.1.1
EOT

echo psion > /etc/hostname

echo T0:2345:respawn:/sbin/getty -L ttyS0 115200 vt100 >> /etc/inittab

exit

rm $targetdir/etc/resolv.conf
rm $targetdir/usr/bin/qemu-arm-static