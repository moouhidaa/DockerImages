FROM  debian:bookworm
#mariadb  :
#store  all  the  data  of wordpress
#install  the  data base
#create  user
#gives  permission
#listens  on the  port  3306
#talks  to  wordpress  only

RUN  apt-get  update  &&  apt-get  install  -y \
        mariadb-server \
        && rm  -rf  /var/lib/lists/*

COPY conf/maria.cnf  /etc/mysql/mariadb.conf.d/50-server.cnf

COPY tools/entrypoint.sh  /setup.sh

RUN  chmod +x  /setup.sh

EXPOSE  3306

#script  run  when  the container  starts and  keep  mariad  run  in  foreground
CMD  ["/setup.sh"]

#mariadb-server install :
#  mysqld  the  database  engine 
#  mysql   command  line  client
#mariadb  tools  helper  utilities

