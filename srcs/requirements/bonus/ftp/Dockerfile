FROM debian:bookworm

RUN apt-get update && apt upgrade -y && apt install  -y\
        vsftpd && rm -rf  /var/lib/apt/lists/*

RUN  mkdir -p /etc/vsftpd

COPY conf/vsftpd.conf  /etc/vsftpd/vsftpd.conf

COPY tools/entrypoint.sh   /entrypoint.sh

RUN chmod +x  /entrypoint.sh

EXPOSE 21 20  30000-30010

ENTRYPOINT [ "/entrypoint.sh" ]