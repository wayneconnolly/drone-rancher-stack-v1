#!/bin/sh
DOCKER_COMPOSE=`find / -name docker-compose.yml`
RANCHER_COMPOSE=`find / -name rancher-compose.yml`
cat ${DOCKER_COMPOSE}
cat ${RANCHER_COMPOSE}
echo "ls rancher" && ls rancher/
/bin/rancher-compose \
 --url http://${PLUGIN_URL}/v1 \
 --access-key ${PLUGIN_ACCESSKEY} \
 --secret-key ${PLUGIN_SECRETKEY} \
 -f ${DOCKER_COMPOSE} -r ${RANCHER_COMPOSE} \
 --verbose -p ${PLUGIN_STACK} up -p -d --force-upgrade --confirm-upgrade
