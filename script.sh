#!/bin/sh

#curl -o rancher-compose.tar.gz https://github.com/rancher/rancher-compose/releases/download/v0.12.5/rancher-compose-linux-amd64-v0.12.5.tar.gz

tar -zxvf rancher-compose.tar.gz
mv rancher-compose-*/rancher-compose /bin/.
chmod +x /bin/rancher-compose
git clone ${PLUGIN_GIT}
/bin/rancher-compose \
 --url http://${PLUGIN_URL}/v1 \
 --access-key ${PLUGIN_ACCESS} \
 --secret-key ${PLUGIN_SECRET} \
 -f /stack/docker-compose.yml -r /stack/rancher-compose.yml \
 --verbose -p ${PLUGIN_STACK} up -p -d --force-upgrade --confirm-upgrade
