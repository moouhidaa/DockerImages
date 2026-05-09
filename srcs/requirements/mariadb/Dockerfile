FROM  debian:bookworm

RUN apt-get update && apt-get upgrade -y && apt-get install -y mariadb-server && rm -rf /var/lib/apt/lists/* 

COPY conf/maria.cnf  /etc/mysql/mariadb.conf.d/50-server.cnf

EXPOSE  3306

COPY tools/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]