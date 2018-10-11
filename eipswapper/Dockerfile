FROM amazonlinux:2

RUN yum install -y awscli

COPY eipswapper.sh /usr/local/bin/eipswapper.sh

ENTRYPOINT /usr/local/bin/eipswapper.sh
