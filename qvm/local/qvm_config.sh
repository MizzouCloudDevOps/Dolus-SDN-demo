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

# run ovs db
ovsdb-server -v --log-file --pidfile --remote=punix:/usr/local/var/run/openvswitch/db.sock >/var/log/ovsdb.log 2>&1 &
sleep 1
# run ovs switch
ovs-vswitchd --pidfile >/var/log/vswitchd.log 2>&1 &
echo -e "\n${GREEN}Open vswitch service started... ${NC}\n"
sleep 1

# set up bridges
echo -e "\n${BLUE}Setting up briges... ${NC}\n"
ovs-vsctl add-br br0 || checkErr "setting up bridge error..."
# setup VXLAN connections
echo -e "\n${BLUE}Setting up VXLAN connections... ${NC}\n"
ovs-vsctl add-port br0 eth1 -- set interface eth1 type=vxlan options:remote_ip=172.18.0.4 options:key=2003
ifconfig br0 100.0.0.104 mtu 1400 up
