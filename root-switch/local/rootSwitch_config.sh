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

#check to make sure argument IPs are provided
if [ "$#" -lt 1 ]
then
    echo -e "\n${RED}Not enough arguments supplied, please provide the IP of the Controller. Exiting...${NC}"
    exit
fi

# run ovs db
ovsdb-server -v --log-file --pidfile --remote=punix:/usr/local/var/run/openvswitch/db.sock >/var/log/ovsdb.log 2>&1 &
sleep 2

# run ovs switch
ovs-vswitchd --pidfile >/var/log/vswitchd.log 2>&1 &
echo -e "\n${GREEN}Open vswitch service started on Root Switch ... ${NC}\n"
sleep 2

# set up bridges
echo -e "\n${BLUE}Setting up briges on Root Switch ... ${NC}\n"
ovs-vsctl add-br br0 || checkErr "Setting up bridge on Root Switch"


# setup VXLAN connections
echo -e "\n${BLUE}Setting up VXLAN connections on Root Switch ... \n"
ovs-vsctl add-port br0 eth1 -- set interface eth1 type=vxlan options:remote_ip=172.18.0.4 options:key=2001
ovs-vsctl add-port br0 eth2 -- set interface eth2 type=vxlan options:remote_ip=172.18.0.5 options:key=2002

ifconfig br0 100.0.0.100 mtu 1400 up
