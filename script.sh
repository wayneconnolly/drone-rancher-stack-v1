#!/bin/sh
RANCHER_COMPOSE=`find / -name rancher-compose.yml`
DOCKER_COMPOSE=`find / -name docker-compose.yml`
echo "rancher-compose.yml @ ${RANCHER_COMPOSE}" 
cat ${RANCHER_COMPOSE}
echo ""
echo "docker-compose.yml @ ${DOCKER_COMPOSE}"
cat ${DOCKER_COMPOSE}
echo ""
echo "Deploying Rancher Stack with force upgrade"
/bin/rancher \
 --url http://${PLUGIN_URL}/v1 \
 --access-key ${PLUGIN_ACCESSKEY} \
 --secret-key ${PLUGIN_SECRETKEY} \
 -f ${DOCKER_COMPOSE} --rancher-file ${RANCHER_COMPOSE} \
 -p ${PLUGIN_STACK} up -p -d --force-upgrade --confirm-upgrade
