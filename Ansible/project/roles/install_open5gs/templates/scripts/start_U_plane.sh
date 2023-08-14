#!/bin/bash

# Start U-Plane process
# add -c <config path> to specify the config
# e.g. screen -dmS upfd /bin/open5gs-upfd -c /path/to/some/upf_config.yaml
# WARNING - upf.log in /var/log/open5gs/upf.log (or in user specified path) can grow to very big sizes
# If you run out of memory on the system, check this file and delete it it's size is very big (was 8 GB in my case)

if [[ $EUID -ne 0]]; then
  echo "Please relaunch the script as root" > &2
  exit 1

if [[ $UID -ne 0 ]]; then
  echo "User who run the script was not logged as root!"
  echo "Remember - to check screens and kill open5gs processes, either login as sudo or execute every command with sudo"
  echo ""
fi
screen -dmS upf /bin/open5gs-upfd
