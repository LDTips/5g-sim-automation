#!/bin/bash

# Start ue process(s)
# It is required to specify at least one config in the "config_paths" array
# Paths can be relative. For example, use ../configs/ue0.yaml

if [[ $EUID -ne 0 ]]; then
  echo "Please relaunch the script as root" >&2
  exit 1
fi

if [[ $UID -ne 0 ]]; then
  echo "User who run the script was not logged as root!"
  echo "Remember - to check screens and kill open5gs processes, either login as sudo or execute every command with sudo"
  echo ""
fi

config_paths=(
  "/path/to/one/config"
  "/path/to/another/config"
)

COUNTER=0
for path in "${config_paths[@]}"; do
  screen -dmS "ue${COUNTER}" /home/open5gs-ansible/UERANSIM/build/nr-ue -c "$path"
  COUNTER=$(( COUNTER+1 ))
done
