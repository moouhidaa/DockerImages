FROM  debian:bookworm

RUN  apt-get update  && apt-get  install  -y\
        php\ 
        php-fpm\
        php-mysql\
        php-curl\
        php-gd\
        php-mbstring\
        php-xml\
        php-zip\
        php-zip\
        sendmail\
        wget\
        default-mysql-client \
        && rm -rf  /var/lib/apt/lists/*
 COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

 COPY tools/setup.sh  /setup.sh

 RUN  chmod +x  /setup.sh

 EXPOSE 9000

 CMD ["/setup.sh"]

 #php  core of PHP language  (the engine)
 #php-fpm manage all  the request  that  are comes  form  the  9000  port
 #php-mysql -> talk  tomaria db  without it  the word  pres cannot  read  ot write  data
 #php-curl -> allow PHP to make  the https request used to  check  update and  download  pluging  themes  and connect  to  the external  APIs
 #php-gd   -> graphic draw libraries allow the  php to  resize  the  images  crop  thumbnails  generate  images upload   them  too
 #php-mbstring -> handles special character from  different  languages
 #php-xml ->allow PHP  to  read the xml  fils // php  nedd it  for data  import ans export rss feeds plugin communication ..
 #php-zip -> handles zip files  
 #and wget for  downloading  
 #all those  extention comes tegother  to full  word press support