#! /bin/bash

#nginx  needs  ssl  to work  onport 443
#ssl needs a certificate 
#where  do we  get  that certifivcate
#"create a self-signed SSL certificate
# so nginx can run HTTPS on port 443

#her we can create any folder  with that path
mkdir  -p  /etc/nginx/ssl

openssl req -x509 -nodes -days 1337 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out    /etc/nginx/ssl/nginx.crt \
    -subj   "/C=MA/ST=Rabat/L=Rabat/O=42/CN=moouhida.42.fr"

#openssl  req
#openssl = tool
#req -=  its  a  reauest  to create  certificates
#openssl has many commands:
#openssl req      → create certificates  ✅ this one
#openssl verify   → verify certificates
#openssl enc      → encrypt files
#openssl passwd   → hash passwords
#-x509
#-x509 stardard  format for  ssl  certificate
#without it  you need  someone to  improve  with  it  ready to  use immediatly
#-nodes 
#no DES  means no  password  protection  on the key  //  without it  nginx  were ask for a password eveery  time it  start
#-days 1337
#-newkey rsa:2048
#newkey generate new  brand new  key rsa:  the ecryption  algo  used 2048 keysize more bigger  more  secure but can be slow
#-keyout  /etc/nginx/ssl/nginx.key
#where to save the private key
#-out /etc/nginx/ssl/nginx.crt
#where  to save  the certificate //nginx sends it on every HTTPS connection

#-subj "/C=MA/ST=Rabat/O=42/CN=moouhida.42.fr"


#openssl has many capabilities:

#1. Generate SSL certificates     ✅ what we use
#2. Encrypt/decrypt files         
#3. Generate passwords/hashes     
#4. Test SSL connections          
#5. Sign documents digitally      
#6. Generate random numbers