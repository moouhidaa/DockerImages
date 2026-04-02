FROM debian:bookworm

RUN  sudo apt upgrade & sudo apt instal \
        vsftpd && rm -rf  /var/lib/apt/lists/*

COPY conf/vsftpd.conf  /vsftpd.conf
COPY tools/entrypoint.sh   /entrypoint.sh

RUN chmod +x  /entrypoint.sh

EXPOSE 21 20  30000-31000

ENTRYPOINT [ "/entrypoint" ]