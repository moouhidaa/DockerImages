FROM  debian:bookworm

RUN   sudo  apt  upgrade && sudo  apt install \
        mariadb-client \
        cron  &&  rm -rf /var/lib/apt/lists/* 
RUN  mkdir  -p   /home/data/backups

COPY tools/backups.sh  /backups.sh

RUN chmod +x  /backups.sh

ENTRYPOINT [ "/backups.sh" ]