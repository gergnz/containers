FROM ubuntu:18.04

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y packer ansible curl wget python-pip git jq

RUN pip install awscli

RUN mkdir -p /ansible/roles && ansible-galaxy install anthcourtney.cis-amazon-linux -p /ansible/roles

RUN sed -i "s/\(2016.03\"\)/\1\n  - \"2018.03\"/" /ansible/roles/anthcourtney.cis-amazon-linux/vars/main.yml

COPY ecs.yml /ansible/ecs.yml
