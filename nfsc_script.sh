#!/bin/bash

#установка утилиты
yum install nfs-utils -y

#включаем firewal
systemctl enable firewalld --now
systemctl status firewalld

#добавляем в __/etc/fstab__ строку_
echo "192.168.50.10:/srv/share/ /mnt nfs vers=3,proto=udp,noauto,x-systemd.automount 0 0" >> /etc/fstab

#выполняем
systemctl daemon-reload
systemctl restart remote-fs.target




