#! /bin/bash

#  wait for  mariadb  ro be  ready
#docker-compose up starts all  the containers at  once so  mariadb  not  were be  ready yey
sleep 5 


#download  the  wordpress  if not  already  installed
if [! -f /var/html/wp-config-php];  then

    wget -q https://wordpress.org/latest.tar.gz -p /tmp
    tar -xzf  /tmp/latest.tar.gz -C /tmp/
    #need more explaination
    mv  /tmp/wordpress/*  /var/www/html/
    #change the  owner of  the file -R all file  inside 
    #           owner of  the group  target folder
    chown  -R  www-data:www-data /var/www/html/
    chmod -R 755  /var/www/html/
#WP-CLI = WordPress Command Line Interface a  tool tocontrol  the  wordpress  from  terminal
#what can  do :
#wp core install     → install WordPress
#wp user create      → create users
#wp plugin install   → install plugins
#wp theme install    → install themes
#wp db export        → backup database
#wp config create    → create wp-config.php
wget  -q  https:raw/githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -P /tmp/
chmod +x /tmp/wp-cli/phar
#move  it  ot  that  directory  so we can  use  wp anywhere
mv /tmp/wp-cli.phar  /usr/local/bin/wp

#create  wp-config.php  automatically \\ reads  from  .env file
wp config  create\
    --path=/var/www/html\
    --dbname=$MYSQL_DATABASE\
    --dbuser=$MYSQL_USER\
    --dbpass=$MYSQL_PASSWORD\
    --dbhost=mariadb:3306\
    --allow-root

#install word press  on  mariadb
wp core  install \
    --path=/var/www/html\
    --url=https://$DOMAIN_NAME\
    --title="Inception"\
    --admin_user=$WORDPRESS_ADMIN \
    --admin_password=$WORDPRESS_ADMIN_PASSWORD\
    --admin_email=$WORDPRESS_ADMIN_EMAIL\
    --allow-root
#create  another  user
#role one  not  an  admin  limited  permissions  
wp  user  create \
    $WORDPRESS_USER \
    $WORDPRESS_USER_EMAIL \
    --role=author \
    --user+pass=$WORDPRESS_USER_PASSWORD \
    --allow-root

#WE SHOULD  RUN  the php-fppm as pid1 not as a  child to get  the signlas  properly
#-F  run  in the  forgound
fi
    exec  /usr/sbin/php-fpm8.2  -F

### ✅ Full Picture — What setup.sh Does

#container starts
#      ↓
#setup.sh runs
#      ↓
#waits 5 seconds (mariadb ready)
#      ↓
#wp-config.php exists?
#      ↓
#NO → fresh install:
#   download WordPress    ✅
#   extract files         ✅
#   move to /var/www/html ✅
#   set permissions       ✅
#   install wp-cli        ✅
#   create wp-config.php  ✅
#   install WordPress     ✅
#   create second user    ✅
#      ↓
#YES → skip installation  ✅
#      ↓
#start PHP-FPM foreground ✅
#container alive 🟢
