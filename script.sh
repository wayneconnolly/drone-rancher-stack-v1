#!/bin/sh
RANCHER_COMPOSE=`find / -name rancher-compose.yml`
DOCKER_COMPOSE=`find / -name docker-compose.yml`
echo "rancher-compose.yml @ ${RANCHER_COMPOSE}\n" 
cat ${RANCHER_COMPOSE}
echo "\n\ndocker-compose.yml @ ${DOCKER_COMPOSE}\n"
cat ${DOCKER_COMPOSE}
echo "\n\nDeploying Rancher Stack with force upgrade\n\n"
/bin/rancher-compose \
 --url http://${PLUGIN_URL}/v1 \
 --access-key ${PLUGIN_ACCESSKEY} \
 --secret-key ${PLUGIN_SECRETKEY} \
 -f rancher/${PLUGIN_PATH}/docker-compose.yml -r rancher/${PLUGIN_PATH}/rancher-compose.yml \
 --verbose -p ${PLUGIN_STACK} up -p -d --force-upgrade --confirm-upgrade
