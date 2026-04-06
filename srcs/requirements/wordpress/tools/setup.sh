#!/bin/bash

#  wait for  mariadb  ro be  ready

#docker-compose up starts all  the containers at  once so  mariadb  not  were be  ready ye
until  mysqladmin ping -h  mariadb  --silent  2>/dev/null; do  sleep 1; done

WP_ADMIN=$(cat 'NR=1{print $1}' /run/secrets/credentials |  cut -d= -f2)
WP_ADMIN_PASSWORD=$(cat 'NR=2{print $1}' /run/secrets/credentials |  cut -d= -f2)
WP_ADMIN_EMAIL=$(cat 'NR=3{print $1}' /run/secrets/credentials |  cut -d= -f2)
WP_USER=$(cat  'NR=4{print $1}' /run/secrets/credentials | cut -d= -f2)
WP_USER_PASSWORD=$(cat  'NR=5{print $1}' /run/secrets/credentials | cut -d= -f2)
WP_PRESS_USER_EMAIL=$(cat 'NR=5{print $1}' /run/secrets/credentials | cut -d= -f2)


MYSQL_PASSWORD=$(cat /run/secrets/db_password)

if [ ! -f /var/www/html/wp-config.php ];  then

    wget -q https://wordpress.org/latest.tar.gz -P /tmp
    tar -xzf  /tmp/latest.tar.gz -C /tmp/
    cp -r  /tmp/wordpress/*  /var/www/html/
    chown  -R  www-data:www-data /var/www/html/
    chmod -R 755  /var/www/html/
    wget  -q  https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -P /tmp/
    chmod +x /tmp/wp-cli.phar
    mv /tmp/wp-cli.phar  /usr/local/bin/wp

    wp config  create \
        --path=/var/www/html \
        --dbname=$MYSQL_DATABASE \
        --dbuser=$MYSQL_USER \
        --dbpass=$MYSQL_PASSWORD \
        --dbhost=mariadb:3306 \
        --allow-root

    wp core  install \
        --path=/var/www/html \
        --url=https://$DOMAIN_NAME \
        --title="Inception" \
        --admin_user=$WP_ADMIN \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL \
        --allow-root

    wp  user  create \
        $WP_PRESS_USER \
        $WP_PRESS_USER_EMAIL \
        --role=author \
        --user_pass=$WP_PRESS_USER_PASSWORD \
        --allow-root
    #allow wp-cli  run  as root  wihtout  any  problems
    wp config  set  WP_REDIS_HOST redis --allow-root
    #raw = save it  a number not string
    wp config  set  WP_REDIS_PORT 6379 --raw --allow-root
    wp config set WP_CASHE true --raw --allow-root

    wp plgin install redis-cache --activate --allow-root
    wp redis  enable  --allow-root
fi
 exec  /usr/sbin/php-fpm8.2  -F
