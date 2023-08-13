#!/bin/bash

# Start U-Plane process
# add -c <config path> to specify the config
# e.g. screen -dm /bin/open5gs-upfd -c /path/to/some/upf_config.yaml
# WARNING - upf.log in /var/log/open5gs/upf.log (or in user specified path) can grow to very big sizes
# If you run out of memory on the system, check this file and delete it it's size is very big (was 8 GB in my case)
screen -dmS upf /bin/open5gs-upfd

if [[ $EUID -ne 0 ]]; then
  echo "User who run the script was not root!"
  echo "Remember - to check screens either login as sudo or execute every screen command with sudo"
fi

echo "Attach to screen to see the logs: screen -ls, then screen -r <name>"
echo "Deattach from screen: ctrl + D inside a screen"
echo "Terminate all screens: pkill screen"