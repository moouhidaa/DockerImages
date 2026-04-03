FROM   debian:bookworm

RUN apt-get  update && apt-get install  -y redis &&  rm -rf /var/apt/lists/*

COPY conf/redis.conf  /etc/redis/redis.conf
COPY tools/entrypoint.sh /entrypoint.sh

RUN chmod  +x /entrypoint.sh

EXPOSE  6379

ENTRYPOINT [ "/entrypoint.sh" ]