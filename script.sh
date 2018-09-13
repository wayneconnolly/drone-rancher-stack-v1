#!/bin/sh
RANCHER_COMPOSE=`find / -name rancher-compose.yml`
DOCKER_COMPOSE=`find / -name docker-compose.yml`
if [[ -n $PLUGIN_ACCESSKEY ]]; then
    ACCESSKEY="$PLUGIN_ACCESSKEY"
fi
if [[ -n $RANCHER_ACCESSKEY ]]; then
    ACCESSKEY="$RANCHER_ACCESSKEY"
fi
if [[ -n $PLUGIN_SECRETKEY ]]; then
    SECRETKEY="$PLUGIN_SECRETKEY"
fi
if [[ -n $RANCHER_SECRETKEY ]]; then
    SECRETKEY="$RANCHER_SECRETKEY"
fi
echo "rancher-compose.yml @ ${RANCHER_COMPOSE}" 
cat ${RANCHER_COMPOSE}
echo ""
echo "docker-compose.yml @ ${DOCKER_COMPOSE}"
cat ${DOCKER_COMPOSE}
echo ""
echo "Deploying Rancher Stack with force upgrade"
echo "${PLUGIN_URL} ${ACCESSKEY} ${SECRETKEY} ${PLUGIN_STACK}"
/bin/rancher --url http://${PLUGIN_URL} --access-key ${ACCESSKEY} --secret-key ${SECRETKEY} up --stack ${PLUGIN_STACK} -d -f ${DOCKER_COMPOSE} --rancher-file ${RANCHER_COMPOSE} --pull --force-recreate --confirm-upgrade
