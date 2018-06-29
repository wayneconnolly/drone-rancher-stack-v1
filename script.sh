#!/bin/sh

#curl -o rancher-compose.tar.gz https://github.com/rancher/rancher-compose/releases/download/v0.12.5/rancher-compose-linux-amd64-v0.12.5.tar.gz

tar -zxvf rancher-compose.tar.gz
mv rancher-compose-*/rancher-compose /bin/.
chmod +x /bin/rancher-compose
git clone ${PLUGIN_REPO} /rancher
/bin/rancher-compose \
 --url http://${PLUGIN_URL}/v1 \
 --access-key ${PLUGIN_ACCESSKEY} \
 --secret-key ${PLUGIN_SECRETKEY} \
 -f /rancher/${PLUGIN_PATH}/docker-compose.yml -r /rancher/${PLUGIN_PATH}/rancher-compose.yml \
 --verbose -p ${PLUGIN_STACK} up -p -d --force-upgrade --confirm-upgrade
