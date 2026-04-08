FROM  debian:bookworm

RUN  apt-get  update && apt upgrade -y && apt install -y\
        mariadb-client \
        &&  rm -rf /var/lib/apt/lists/* 
RUN  mkdir -p /home/moouhida/data/backup

COPY tools/backup.sh  /backup.sh

RUN chmod +x  /backup.sh

ENTRYPOINT [ "/backup.sh" ]