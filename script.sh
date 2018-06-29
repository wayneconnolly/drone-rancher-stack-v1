#!/bin/sh

curl -o rancher-compose.tar.gz https://github.com/rancher/rancher-compose/releases/download/v0.12.5/rancher-compose-linux-amd64-v0.12.5.tar.gz

tar -zxvf rancher-compose.tar.gz
mv rancher-compose-*/rancher-compose /bin/.
chmod +x /bin/rancher-compose

/bin/rancher-compose \
 --url http://${DOMAIN}/v1 \
 --access-key ${ACCESS} \
 --secret-key ${SECRET} \
 -f /stack/docker-compose.yml -r /stack/rancher-compose.yml \
 --verbose -p ${STACK} up -p -d --force-upgrade --confirm-upgrade
