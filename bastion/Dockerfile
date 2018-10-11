FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
    openssh-server \
    python \
    python-pip \
    curl \
    rsyslog \
    && \
    pip install awscli

COPY sshd_config /etc/ssh/sshd_config
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN useradd -s /bin/bash -k /etc/skel -m bastion
RUN usermod -p '*' bastion
RUN mkdir -p /home/bastion/.ssh/
RUN chmod -R 700 /home/bastion/.ssh
RUN touch /home/bastion/.ssh/authorized_keys
RUN chmod 600 /home/bastion/.ssh/authorized_keys
RUN chown -R bastion:bastion /home/bastion/.ssh
RUN mkdir /run/sshd

EXPOSE 2200

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

CMD ["/usr/sbin/sshd", "-D", "-e"]
