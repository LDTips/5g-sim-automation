#!/bin/bash

# Start ue process(s)
# It is required to specify at least one config in the "config path array"
# Remember - it can be handy to use $(pwd) variable inside "" strings

config_paths=(
    "/path/to/one/config"
    "/path/to/another/config"
)

COUNTER=0
for path in "${config_paths[@]}"; do
  screen -dmS "ue${counter}" /home/open5gs-ansible/UERANSIM/build/nr-ue -c "$path"
  COUNTER=$(( COUNTER+1 ))
done

if [[ $EUID -ne 0 ]]; then
  echo "User who run the script was not root!"
  echo "Remember - to check screens either login as sudo or execute every screen command with sudo"
fi

echo "Attach to screen to see the logs: screen -ls, then screen -r <name>"
echo "Deattach from screen: ctrl + D inside a screen"
echo "Terminate all screens: pkill screen"
