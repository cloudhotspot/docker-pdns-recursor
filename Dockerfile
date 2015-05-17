FROM ubuntu:14.04.2
MAINTAINER justin.menga@cloudhotspot.co
RUN apt-get update && \
    apt-get install pdns-recursor -y

VOLUME ["/etc/powerdns", "/var/zones"]
ADD recursor.conf /etc/powerdns/recursor.conf
ADD zones/example.com /var/zones/example.com

EXPOSE 53/udp
ENTRYPOINT ["/usr/sbin/pdns_recursor", "--daemon=no"]