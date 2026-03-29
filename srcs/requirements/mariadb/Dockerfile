FROM  debian:bookworm
#mariadb  :
#store  all  the  data  of wordpress
#install  the  data base
#create  user
#gives  permission
#listens  on the  port  3306
#talks  to  wordpress  only
RUN apt-get update && apt-get install -y  mariadb-server && rm -rf /var/lib/apt/lists/* 

COPY conf/maria.cnf  /etc/mysql/mariadb.conf.d/50-server.cnf

EXPOSE  3306

COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
CMD ["mysqld"]
#mariadb-server install :
#  mysqld  the  database  engine 
#  mysql   command  line  client
#mariadb  tools  helper  utilities

