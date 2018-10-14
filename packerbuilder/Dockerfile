FROM ubuntu:18.04
MAINTAINER Greg Cockburn, gergnz@gmail.com

RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update && apt-get upgrade -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y packer ansible curl wget python-pip git jq

RUN pip install awscli
RUN mkdir -p /ansible/roles && ansible-galaxy install anthcourtney.cis-amazon-linux -p /ansible/roles
RUN sed -i "s/\(2016.03\"\)/\1\n  - \"2018.03\"/" /ansible/roles/anthcourtney.cis-amazon-linux/vars/main.yml

COPY ecs.yml /ansible/ecs.yml

# Cleanup
RUN DEBIAN_FRONTEND=noninteractive apt-get purge -y build-essential
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
