#!/bin/bash

# Start gnb process
# It is required to add -c <config path> to specify the config
# e.g. screen -dm ./home/open5gs-ansible/UERANSIM/nr-gnb -c /path/to/some/gnb/config.yaml
screen -dm /home/open5gs-ansible/UERANSIM/build/nr-gnb -c # INSERT CONFIG PATH HERE

if [[ $EUID -ne 0 ]]; then
  echo "User who run the script was not root!"
  echo "Remember - to check screens either login as sudo or execute every screen command with sudo"
fi

echo "Attach to screen to see the logs: screen -ls, then screen -r <name>"
echo "Deattach from screen: ctrl + D inside a screen"
echo "Terminate all screens: pkill screen"
