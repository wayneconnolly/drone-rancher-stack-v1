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

/bin/rancher --url http://${PLUGIN_URL} --access-key ${ACCESSKEY} --secret-key ${SECRETKEY} stacks ls > /status

if grep -q degraded /status; then
    echo 'Stack is degraded. Killing stack now!'
    sed -i '/degraded/!d' /status
    ID=`sed -e 's/\s.*$//' /status`
    /bin/rancher --url http://${PLUGIN_URL} --access-key ${ACCESSKEY} --secret-key ${SECRETKEY} rm $ID
    sleep 60s
    echo 'Rebuilding new stack'
    /bin/rancher --url http://${PLUGIN_URL} --access-key ${ACCESSKEY} --secret-key ${SECRETKEY} up --stack ${PLUGIN_STACK} -d -f ${DOCKER_COMPOSE} --rancher-file ${RANCHER_COMPOSE} --pull --force-recreate --confirm-upgrade
else
    echo 'Stack healthy or not found. Creating/Updating stack with force upgrade'
    /bin/rancher --url http://${PLUGIN_URL} --access-key ${ACCESSKEY} --secret-key ${SECRETKEY} up --stack ${PLUGIN_STACK} -d -f ${DOCKER_COMPOSE} --rancher-file ${RANCHER_COMPOSE} --pull --force-recreate --confirm-upgrade
fi
