FROM debian:bookworm

RUN  mkdir -p /var/www/html && apt-get update && apt-get upgrade -y && apt  install  -y \
                php \
                php-mysqli \
                wget \
                && rm -rf  /var/lib/apt/lists/*

RUN  wget -O /var/www/html/adminer.php  \
    https://www.adminer.org/latest.php

COPY  tools/entrypoint.sh  /entrypoint.sh

RUN  chmod  +x  /entrypoint.sh

EXPOSE 8080

ENTRYPOINT [ "/entrypoint.sh" ]