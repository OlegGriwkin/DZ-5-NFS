#!/bin/bash

#установка утилиты
yum install nfs-utils -y

#включение firewall и проверка, что он работает
systemctl enable firewalld --now
systemctl status firewalld

#разрешаем в firewall доступ к сервисам NFS
firewall-cmd --add-service="nfs3" \
       --add-service="rpc-bind" \
       --add-service="mountd" \
       --permanent
firewall-cmd --reload

#включение сервера NFS
systemctl enable nfs --now

#проверка наличие слушаемых портов
ss -tnplu

#создаём и настраиваем директорию upload
mkdir -p /srv/share/upload
chown -R nfsnobody:nfsnobody /srv/share
chmod 0777 /srv/share/upload

#
cat << EOF > /etc/exports
/srv/share 192.168.50.11/32(rw,sync,root_squash)
EOF

#экспорт директории
exportfs -r





