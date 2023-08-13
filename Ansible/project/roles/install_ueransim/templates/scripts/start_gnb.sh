#!/bin/bash

# Start gnb process
# It is required to add -c <config path> to specify the config
# e.g. screen -dm ./home/open5gs-ansible/UERANSIM/nr-gnb -c /path/to/some/gnb/config.yaml

if [[ $EUID -ne 0]]; then
  echo "Please relaunch the script as root" > &2
  exit 1

if [[ $UID -ne 0 ]]; then
  echo "User who run the script was not logged as root!"
  echo "Remember - to check screens and kill open5gs processes, either login as sudo or execute every command with sudo"
  echo ""
fi

screen -dmS gnb /home/open5gs-ansible/UERANSIM/build/nr-gnb -c # INSERT CONFIG PATH HERE

echo "Attach to screen to see the logs: screen -ls, then screen -r <name>"
echo "Deattach from screen: ctrl + D inside a screen"
echo "Terminate all screens: pkill screen"
