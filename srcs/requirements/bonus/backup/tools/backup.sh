#!/bin/bash

MYSQL_PASSWORD=$(cat /run/secrets/db_password)

until mysqladmin  ping  -h  mariadb --silent; do
    echo "waiting for mariadb"
    sleep 3
done

while  true
do
    DATE=$(date +%Y-%m-%d_%H-%M-%S)
    echo "Starting Backup (per 1h)...⏳"
    mysqldump  -h  mariadb -u  $MYSQL_USER  -p$MYSQL_PASSWORD $MYSQL_DATABASE > /backup/backup_mariadb_$DATE.sql
    tar -czf /backup/db_wordpress_$DATE.tar.gz  /var/www/html
    if [ $? -ne 0 ];then
        echo "Backup failed -_-"
        exit 1
    fi
    echo "Backup Complete with Success 👻"
    sleep 7200
done