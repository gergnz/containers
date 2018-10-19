FROM jenkins/jenkins:lts
MAINTAINER Greg Cockburn, gergnz@gmail.com

ARG CADDY_VERSION=0.11.0

USER root

RUN curl -fsSL https://github.com/mholt/caddy/releases/download/v${CADDY_VERSION}/caddy_v${CADDY_VERSION}_linux_amd64.tar.gz -o /tmp/caddy.tar.gz \
  && tar -C /usr/local/bin -zxf /tmp/caddy.tar.gz caddy \
  && rm -rf /tmp/caddy.tar.gz

RUN mkdir -p /etc/caddy

COPY Caddyfile /etc/caddy/Caddyfile

COPY caddy-jenkins.sh /usr/local/bin/caddy-jenkins.sh

RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update
RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y apt-utils
RUN DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y python-pip python-setuptools\
&& pip install wheel && pip install awscli

USER ${user}

ENTRYPOINT ["/sbin/tini", "--", "/usr/local/bin/caddy-jenkins.sh"]

# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
