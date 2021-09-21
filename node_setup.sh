#!/bin/bash

echo "Acquiring Controller public IP address... "
export Controller_Public_IP=$(dig +short myip.opendns.com @resolver1.opendns.com)

echo "Controller public IP address is: "
echo $Controller_Public_IP

echo "Setting up controller switch node "
docker exec controller bash -c "service apache2 start && service mysql start && bash"
echo "Setting up slave switch node "
docker exec rootswitch bash -c "bash /local/rootSwitch_config.sh ${Controller_Public_IP}"
echo "Setting up slave switch node "
docker exec slaveswitch bash -c "bash /local/slaveSwitch_config.sh ${Controller_Public_IP}"
echo "Setting up server switch node "
docker exec server bash -c "bash /local/server_config.sh"
echo "Setting up attacker switch node "
docker exec attacker bash -c "bash /local/attacker_config.sh && bash /local/attacker_preinstall.sh"
echo "Setting up user switch node "
docker exec user bash -c "bash /local/user_config.sh"
echo "Setting up qvm switch node "
docker exec qvm bash -c "bash /local/qvm_config.sh"
