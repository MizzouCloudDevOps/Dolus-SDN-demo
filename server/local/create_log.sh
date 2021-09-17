#!/bin/bash

#Color declarations
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
LIGHTBLUE='\033[1;34m'
LIGHTGREEN='\033[1;32m'
NC='\033[0m' # No Color

function createFiles() {
    for i in {0..60}; do
        head -c 1M < /dev/urandom > log$i.log
    done
}

spin[0]="-"

spin[1]="\\"

spin[2]="|"

spin[3]="/"

#Call the createFiles function I wrote and put it in the background.
createFiles &
#Get the PID of the function so that I can check to see if it's completed.
success=$?

processId=$!

echo -n "[Creating Log Files] ${spin[0]}"

#As long as the function is being executed, show the spinner.
while [ "$(ps a | awk '{print $1}' | grep $processId)" ] ; do

  for i in "${spin[@]}"

  do

        echo -ne "\b$i"

        sleep 0.1

  done

done

#Check to see if the log file installation was successful.
if [ $success -eq 0 ] ; then
    echo -e "${GREEN}\nLog file creation complete!${NC}"
else
    echo -e "${RED}\nLog file creation failed${NC}"
fi