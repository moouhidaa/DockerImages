FROM  debian:bookworm

RUN  apt-get  update && apt upgrade -y && apt install -y\
        mariadb-client \
        &&  rm -rf /var/lib/apt/lists/*

COPY tools/backup.sh  /backup.sh

RUN chmod +x  /backup.sh

ENTRYPOINT [ "/backup.sh" ]