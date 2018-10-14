FROM amazonlinux:2
MAINTAINER Greg Cockburn, gergnz@gmail.com

RUN yum install -y awscli

COPY eipswapper.sh /usr/local/bin/eipswapper.sh

ENTRYPOINT /usr/local/bin/eipswapper.sh

RUN yum clean all
