#!/bin/sh -ex

mount -t ext4 /dev/sda3 /mnt

echo "http://dl-cdn.alpinelinux.org/alpine/v3.7/community" >> /mnt/etc/apk/repositories

apk upgrade --root=/mnt --update-cache --available && \
	apk add --root=/mnt --no-cache sudo openssl openssh && \
	apk add --root=/mnt --no-cache virtualbox-guest-additions virtualbox-guest-modules-virthardened

RETVAL=$?

ln -s /etc/init.d/sshd /mnt/etc/runlevels/default/sshd

cp /mnt/etc/ssh/sshd_config /tmp/sshd_config

sed \
  -e 's/^#PermitRootLogin .*/PermitRootLogin yes/' \
  -e 's/^#PubkeyAuthentication yes/PubkeyAuthentication yes/' \
  -e 's/^#PasswordAuthentication yes/PasswordAuthentication yes/' \
  -e 's/^#UseDNS no/UseDNS no/' /tmp/sshd_config > /mnt/etc/ssh/sshd_config
  
rm -rf /usr/share/man /tmp/* /var/cache/apk/*

if [ $RETVAL -eq 0 ]; then
	reboot
fi;

