#!/bin/bash

#  wait for  mariadb  ro be  ready
#docker-compose up starts all  the containers at  once so  mariadb  not  were be  ready ye
until  mysqladmin ping -h  mariadb  --silent  2>/dev/null; do  sleep 1; done
cat $?

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
        --admin_user=$WORDPRESS_ADMIN \
        --admin_password=$WORDPRESS_ADMIN_PASSWORD \
        --admin_email=$WORDPRESS_ADMIN_EMAIL \
        --allow-root

    wp  user  create \
        $WORDPRESS_USER \
        $WORDPRESS_USER_EMAIL \
        --role=author \
        --user_pass=$WORDPRESS_USER_PASSWORD \
        --allow-root

    wp config  set  WP_REDIS_HOST redis --allow-root
    wp config  set  WP_REDIS_PORT 6379 --raw --allow-root
    wp config set WP_CASH true --raw --allow-root

    wp plgin install redis-cashe --activate --allow-root
    wp redis  enabe  --allow-root
fi
 exec  /usr/sbin/php-fpm8.2  -F
