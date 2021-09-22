#!/bin/bash

#Color declarations
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
LIGHTBLUE='\033[1;34m'
LIGHTGREEN='\033[1;32m'
NC='\033[0m' # No Color

function checkErr() {
    echo -e "${RED}$1 failed. Exiting.${NC}" >&2; exit;
}

echo -e "\n${BLUE}Acquiring Controller public IP address... ${NC}"
export Controller_Public_IP=$(dig +short myip.opendns.com @resolver1.opendns.com) || checkErr "Acquiring Controller public IP"

echo -e "\n${BLUE}Controller public IP address is: ${NC}"
echo $Controller_Public_IP

echo -e "\n${BLUE}Setting up root switch node ${NC}"
docker exec rootswitch bash -c "bash /local/rootSwitch_config.sh ${Controller_Public_IP}" || checkErr "Configuring Root Switch"

echo -e "\n${BLUE}Setting up slave switch node ${NC}"
docker exec slaveswitch bash -c "bash /local/slaveSwitch_config.sh ${Controller_Public_IP}" || checkErr "Configuring Slave Switch"

echo -e "\n${BLUE}Setting up server node ${NC}"
docker exec server bash -c "bash /local/server_config.sh" || checkErr "Configuring Server"

echo -e "\n${BLUE}Setting up attacker node ${NC}"
docker exec attacker bash -c "bash /local/attacker_config.sh" || checkErr "Configuring Attacker"

echo -e "\n${BLUE}Setting up user node ${NC}"
docker exec user bash -c "bash /local/user_config.sh" || checkErr "Configuring User"

echo -e "\n${BLUE}Setting up qvm node ${NC}"
docker exec qvm bash -c "bash /local/qvm_config.sh" || checkErr "Configuring QVM"
 
echo -e "\n${GREEN}Finished configuring OVS on all the nodes... ${NC}"