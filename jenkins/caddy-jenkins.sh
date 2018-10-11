#! /bin/bash -e

/usr/local/bin/caddy -log stdout -agree=true -conf=/etc/caddy/Caddyfile -root=/var/tmp &

/usr/local/bin/jenkins.sh
