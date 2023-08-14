#!/bin/bash

# Start C-Plane processes
# add -c <config path> to specify the configs for each element
# e.g. screen -dm /bin/open5gs-ausf -c /path/to/some/ausf_config.yaml

if [[ $EUID -ne 0]]; then
  echo "Please relaunch the script as root" > &2
  exit 1

if [[ $UID -ne 0 ]]; then
  echo "User who run the script was not logged as root!"
  echo "Remember - to check screens and kill open5gs processes, either login as sudo or execute every command with sudo"
  echo ""
fi

screen -dmS nrfd /bin/open5gs-nrfd
sleep 0.5
screen -dmS scpd /bin/open5gs-scpd
sleep 0.5
screen -dmS amfd /bin/open5gs-amfd
sleep 0.5
screen -dmS smfd /bin/open5gs-smfd
sleep 0.5
screen -dmS ausfd /bin/open5gs-ausfd
sleep 0.5
screen -dmS udmd /bin/open5gs-udmd
sleep 0.5
screen -dmS udrd /bin/open5gs-udrd
sleep 0.5
screen -dmS pcfd /bin/open5gs-pcfd
sleep 0.5
screen -dmS nssfd /bin/open5gs-nssfd
sleep 0.5
screen -dmS bsfd /bin/open5gs-bsfd
