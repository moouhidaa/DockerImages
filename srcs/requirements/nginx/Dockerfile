FROM debian:bookworm # cause we need an linux  env inside  the conatainer that why we download  Layer 1 → Linux kernel interfaces
#Layer 2 → Core filesystem structure 
#Layer 3 → Basic debian tools & libs  
#without  it   no file  system no apt  no bash  cant install  anything cant run anything 
RUN apt-get update && apt-get install  -y \
    nginx\
    openssl\
    && rm -rf /var/lib/apt/lists/*

COPY conf/conf.nginx.conf /etc/nginx/conf.d/default.conf

COPY tools/generate-certs.sh /generate-certs.sh

RUN  chmod +x /generate-certs.sh && .generate-certs.sh

EXPOSE   443

CMD   ["nginx" , "g", "daemon off;"] #  run every time container  starts and the above  ones  tun  once
#and  the container are  a live as  long as CMD is running
#daemon off = nginx  stay  in foreground  docker see it  and  the container stay alive
