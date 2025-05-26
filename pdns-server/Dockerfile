# Taken from: https://github.com/PowerDNS-Admin/PowerDNS-Admin/blob/master/docker-test/Dockerfile.pdns
FROM ubuntu:latest

RUN apt-get update && apt-get install -y pdns-backend-sqlite3 pdns-server sqlite3

RUN rm -f /etc/powerdns/pdns.d/pdns.simplebind.conf
RUN rm -f /etc/powerdns/pdns.d/bind.conf

RUN mkdir -p /var/empty/var/run

COPY --chmod=0755 entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
