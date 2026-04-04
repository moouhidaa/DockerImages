#!/bin/bash
mkdir -p /run/mysqld 
chown -R mysql:mysql /run/mysqld

mysqld_safe &
#wiat for  mariadb to  fully start /wihtout  it  next  command  whoule  run  before  mariadb  and  fail
until  mysqladmin  ping  --silent ;  do  sleep 1;done

#read password  from  secrets
MYSQL_PASSWORD=$(cat /run/secrets/db_password)
MYSQL_ROOT_PASSWORD=$(cat  /run/secrets/db_root_password)

#opens mysql  session as root  user  /everythin until  the next  EOF  is sql commad to run
mysql -u  root  <<EOF

CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};

CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';

GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';

ALTER  USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';

DELETE  FROM mysql.user WHERE User='';

DELETE FROM mysql.user WHERE User='root'  AND Host NOT IN  ('localhost' , '127.0.0.1');
 
FLUSH PRIVILEGES;
EOF

mysqladmin  -u  root  -p${MYSQL_ROOT_PASSWORD} shutdown

exec mysqld