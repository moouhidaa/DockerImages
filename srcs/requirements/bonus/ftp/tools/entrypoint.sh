#!/bin/bash


FTP_USER=$(grep '^FTP_USER=' /run/secrets/credentials | cut  -d= -f2)
FTP_PASS=$(grep '^FTP_PASS=' /run/secrets/credentials | cut  -d= -f2)

useradd -d /var/www/html  $FTP_USER

echo  "$FTP_USER:$FTP_PASS" | chpasswd

chown -R "$FTP_USER:$FTP_USER" /var/www/html

mkdir -p  /var/run/vsftpd/empty

exec  vsftpd   /etc/vsftpd/vsftpd.conf