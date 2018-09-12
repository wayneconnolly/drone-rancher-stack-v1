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
/bin/rancher --url http://${PLUGIN_URL} --access-key ${PLUGIN_ACCESSKEY} --secret-key ${PLUGIN_SECRETKEY} up --stack ${PLUGIN_STACK} -d -f ${DOCKER_COMPOSE} --rancher-file ${RANCHER_COMPOSE} --pull --force-recreate --confirm-upgrade
