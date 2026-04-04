FROM  debian:bookworm

RUN   apt upgrade && apt install \
        mariadb-client \
        cron  &&  rm -rf /var/lib/apt/lists/* 
RUN  mkdir -p /home/moouhida/data/backup

COPY tools/backup.sh  /backup.sh

RUN chmod +x  /backup.sh

ENTRYPOINT [ "/backup.sh" ]