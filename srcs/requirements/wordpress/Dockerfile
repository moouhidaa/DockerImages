FROM  debian:bookworm

RUN  apt-get update  && apt-get  install  -y\
        php\ 
        php-fpm\
        php-mysqli\
        php-curl\
        php-mbstring\
        wget\
        default-mysql-client \
        && rm -rf  /var/lib/apt/lists/*
 COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

 COPY tools/setup.sh  /setup.sh

 RUN  chmod +x  /setup.sh

 EXPOSE 9000

 CMD ["/setup.sh"]
