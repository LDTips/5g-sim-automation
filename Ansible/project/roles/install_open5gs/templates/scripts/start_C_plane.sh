#!/bin/bash

# Start C-Plane processes
# add -c <config path> to specify the configs for each element
# e.g. screen -dm /bin/open5gs-ausf -c /path/to/some/ausf_config.yaml
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

if [[ $EUID -ne 0 ]]; then
  echo "User who run the script was not root!"
  echo "Remember - to check screens either login as sudo execute every screen command with sudo"
fi

echo "Attach to screen to see the logs: screen -ls, then screen -r <name>"
echo "Deattach from screen: ctrl + D inside a screen"
echo "Terminate all screens: pkill screen"
