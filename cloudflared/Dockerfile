FROM ubuntu:18.04
MAINTAINER Greg Cockburn, gergnz@gmail.com

RUN apt-get update && \
    apt-get full-upgrade --yes && \
    apt-get install -y wget ca-certificates && \
    apt-get install -f && \
    apt-get autoclean --yes && \
    apt-get clean --yes

RUN cd /tmp && \
    wget https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-amd64.tgz && \
    tar -C / -zxf cloudflared-stable-linux-amd64.tgz
COPY config.yaml /config.yaml

EXPOSE 53/tcp
EXPOSE 53/udp

CMD /cloudflared --config /config.yaml proxy-dns --port 53 --address 0.0.0.0
