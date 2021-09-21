#!/bin/bash

export Controller_Public_IP=$(dig +short myip.opendns.com @resolver1.opendns.com)
echo $Controller_Public_IP

docker exec controller bash -c "service apache2 start && service mysql start && bash"

docker exec rootswitch bash -c "bash /local/rootSwitch_config.sh ${Controller_Public_IP}"

docker exec slaveswitch bash -c "bash /local/slaveSwitch_config.sh ${Controller_Public_IP}"


docker exec server bash -c "bash /local/server_config.sh"
docker exec attacker bash -c "bash /local/attacker_config.sh && bash /local/attacker_preinstall.sh"

docker exec user bash -c "bash /local/user_config.sh"
docker exec qvm bash -c "bash /local/qvm_config.sh"
