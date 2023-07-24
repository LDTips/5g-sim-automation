#!/bin/bash

# Start U-Plane process
# add -c <config path> to specify the config
# e.g. screen -dm /bin/open5gs-upfd -c /path/to/some/upf_config.yaml
screen -dmS upf /bin/open5gs-upfd

if [[ $EUID -ne 0 ]]; then
  echo "User who run the script was not root!"
  echo "Remember - to check screens either login as sudo or execute every screen command with sudo"
fi

echo "Attach to screen to see the logs: screen -ls, then screen -r <name>"
echo "Deattach from screen: ctrl + D inside a screen"
echo "Terminate all screens: pkill screen"
