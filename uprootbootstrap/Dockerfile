FROM amazonlinux:2
MAINTAINER Greg Cockburn, gergnz@gmail.com

COPY bootstrap.sh /usr/local/bin/bootstrap.sh

RUN mkdir -p /efs/shared

VOLUME /efs/shared

ENTRYPOINT /usr/local/bin/bootstrap.sh

RUN yum clean all
