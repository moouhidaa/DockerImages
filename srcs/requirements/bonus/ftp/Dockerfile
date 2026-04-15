FROM debian:bookworm

RUN apt-get update && apt upgrade && apt install  -y\
        vsftpd && rm -rf  /var/lib/apt/lists/*

COPY conf/vsftpd.conf  /vsftpd.conf
COPY tools/entrypoint.sh   /entrypoint.sh

RUN chmod +x  /entrypoint.sh

EXPOSE 21 20  30000-30010

ENTRYPOINT [ "/entrypoint.sh" ]