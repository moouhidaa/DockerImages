#!/bin/bash

MYSQL_PASSWORD=$(cat /run/secrets/db_password)

while  true
do
    echo "Starting Backup (per 1h)...⏳"
    mysqldump  -h  mariadb -u  $MYSQL_USER  -p$MYSQL_PASSWORD $MYSQL_DATABASE >  /home/moouhida/data/backup_mariadb.sql
    tar -czf /home/moouhida/data/db_wordpress.tar.gz  /var/www/html
    echo "Backup Complete with Success 👻"
    sleep 7200
done