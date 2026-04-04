#!/bin/bash

#create a  user and  add  that  home to  that  path  instead  of /home/username
FTP_USER=$(cat 'NR=$6{pribt $1}' /run/secrets/credentials.txt | cut  -d= -f2)
FTP_PASS=$(cat 'NR=$7{pribt $1}' /run/secrets/credentials.txt | cut  -d= -f2)

useradd  -m -d /var/www/html  $FTP_USER

#then set  the  password  we  just  created
echo  "$FTP_USER:$FTP_PASS" | chpasswd
#chanege  the owner  fo those files  that  in that dir to ftp_user so he can upload 
chown -R "$FTP_USER:$FTP_USER" /var/www/html

mkdir -p  /var/run/vsftpd/empty

exec  vsftpd   /etc/vsftp/vsftpd.conf