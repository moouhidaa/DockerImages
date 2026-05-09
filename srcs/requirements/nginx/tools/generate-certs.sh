#! /bin/bash

mkdir  -p  /etc/nginx/ssl

openssl req -x509 -nodes -days 1337 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out    /etc/nginx/ssl/nginx.crt \
    -subj   "/C=MA/ST=Rabat/L=Rabat/O=42/CN=moouhida.42.fr"
