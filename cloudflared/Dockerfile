FROM ubuntu:18.04
MAINTAINER Greg Cockburn, gergnz@gmail.com

COPY cloudflared /cloudflared
COPY config.yaml /config.yaml

EXPOSE 53/tcp
EXPOSE 53/udp

CMD ["/cloudflared", "--config", "/config.yaml", "proxy-dns", "--port 53", "--address 0.0.0.0"]
