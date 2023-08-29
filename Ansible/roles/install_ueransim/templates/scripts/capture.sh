#!/bin/bash

if [[ $EUID -ne 0 ]]; then
  echo "Please relaunch the script as root" >&2
  exit 1
fi

screen -dmS int_tcpdump tcpdump -v -i enp0s8 -f "not host 192.168.56.1 and not arp and not port 5353" -w ../captures/int_dump.pcap
screen -dmS lo_tcpdump tcpdump -v -i lo -w ../captures/lo_dump.pcap