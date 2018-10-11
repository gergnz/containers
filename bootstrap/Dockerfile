FROM amazonlinux:2

COPY bootstrap.sh /usr/local/bin/bootstrap.sh

RUN mkdir -p /efs/shared

VOLUME /efs/shared

ENTRYPOINT /usr/local/bin/bootstrap.sh
