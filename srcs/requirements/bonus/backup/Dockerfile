FROM  debian:bookworm

RUN   apt upgrade && apt install \
        mariadb-client \
        cron  &&  rm -rf /var/lib/apt/lists/* 
RUN  mkdir -p /home/moouhida/data/backups

COPY tools/backups.sh  /backups.sh

RUN chmod +x  /backups.sh

ENTRYPOINT [ "/backups.sh" ]