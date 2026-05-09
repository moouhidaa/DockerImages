#!/bin/bash


mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

mysqld &

until  mysqladmin  ping  --silent ;  do sleep 1;done


MYSQL_PASSWORD=$(cat /run/secrets/db_password)
MYSQL_ROOT_PASSWORD=$(cat  /run/secrets/db_root_password)

mysql -u  root  <<EOF

CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};

CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';

GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';

ALTER  USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';

DELETE  FROM mysql.user WHERE User='';

FLUSH PRIVILEGES;

USE wordpress;

CREATE TABLE student (
id      INT AUTO_INCREMENT PRIMARY KEY,
name    VARCHAR(100),
email   VARCHAR(100),
country VARCHAR(60)
);

INSERT INTO student (name, email, country) VALUES ('Mouaad', 'mouad@42.fr', 'morocco');
INSERT INTO student (name, email, country) VALUES ('halima', 'halima@42.fr', 'bengladish');
INSERT INTO student (name, email, country) VALUES ('rabat_tester', 'rabat@42.fr', 'computer');
INSERT INTO student (name  ,email,country) VALUES ('oussama', 'ousaama@gmail.com', 'idrami')

EOF

mysqladmin  -u  root  -p${MYSQL_ROOT_PASSWORD} shutdown

exec mysqld