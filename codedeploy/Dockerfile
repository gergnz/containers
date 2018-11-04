FROM amazonlinux:2
MAINTAINER Greg Cockburn, gergnz@gmail.com

RUN yum install -y awscli ruby wget procps jq

RUN version=$(curl -s https://aws-codedeploy-ap-southeast-2.s3.amazonaws.com/latest/VERSION | jq -r '.rpm') && \
    rpm -Uvh --noscripts "https://aws-codedeploy-ap-southeast-2.s3.amazonaws.com/$version"

COPY codedeployagent.sh /usr/local/bin/codedeployagent.sh
COPY tagswapper.sh /usr/local/bin/tagswapper.sh

ENTRYPOINT /usr/local/bin/codedeployagent.sh

RUN yum clean all
