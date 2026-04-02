#!/bin/bash

while  true

do
    echo "Starting Backup (per 1h)...⏳"
    mysqldump  -h  mariadb -u  $DB_SUER  -p $DB_PASSWORD $DB_NAME >  /home/data/backup_mariadb.sql
    tar -czf /home/data/db_wordpress.tar.gz  /var/www/html
    echo "Backup Complete with Success 👻"
    sleep 7200
done