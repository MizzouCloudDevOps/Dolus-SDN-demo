#!/bin/bash

#This script will copy 100 log files from a remote server to a local server.
#It will take the hostname and username of the remote server as command line arguments.

#Color declarations
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
LIGHTBLUE='\033[1;34m'
LIGHTGREEN='\033[1;32m'
NC='\033[0m' # No Color

#Ignore the weird spacing. I promise it looks good when it's echoed out to the screen.
echo -e ${LIGHTBLUE}"################################################################"
echo "# Log File Retrieval Script  #"
echo "#                                                              #"
echo -e "# ${LIGHTGREEN}Syntax: ./copy_logfiles.sh username hostname [-p port] ${LIGHTBLUE}#"
echo "#                                                                #"
echo "# This script will copy 100 log files from a remote server.      #"
echo "# To run this script, please specify the username and hostname   #"
echo "# of the remote server as the first and second command line      #"
echo "# arguments respectively. You can also specify which SSH port    #"
echo "# the script should use using the -p flag. #"
echo -e "################################################################"${NC}
echo "" #Acts as a newline by outputting nothing.

function checkErr() {
    echo -e "${RED}$1 failed. Exiting.${NC}" >&2; exit;
}

#Check to see if an argument has been supplied. If not, exit the script.
if [ -z "$2" ]; then
    echo -e "${RED}Incorrect number of arguments supplied. Please supply the username and hostname of the remote server as arguments. Exiting.${NC}"
    exit
fi

#echo "Directory flag functionality not yet completed."

port=22
username=$1
remote_server=$2
regex='^[0-9]+$'
if [ ! -z "$3" ]; then
    if [ $3 = "-p" ]; then
        if ! [[ "$4" =~ $regex ]]; then
            echo -e "${RED}Port flag specified, but port was not entered correctly. Exiting.${NC}"
            exit
        else
            port=$4
        fi
    else
        echo -e "${RED}Flag ${NC}$3${RED} is not valid. Please try again using the -p flag or without the -p flag if you want to use the default port of 22. Exiting.${NC}"
        exit
    fi
fi
files=""

for i in {0..60}; do
    if [ -z "$files" ]; then
        files="log$i.log"
    else
        files="$files log$i.log"
    fi
done

#mkdir logfiles || checkErr "Log file directory creation"
scp -P port $username@$remote_server:"$files" .