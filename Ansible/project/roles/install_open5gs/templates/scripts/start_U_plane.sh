#!/bin/bash

stop_all_child_jobs() {
    echo ""
    echo "Stopping UPF daemon..."
    pkill -P $$
    echo "UPF job stopped"
}

trap stop_all_child_jobs EXIT SIGTERM SIGINT

# Start U-Plane process
# add -c <config path> to specify the config
# e.g. /bin/open5gs-upfd -c /path/to/some/upf_config > /dev/null &
/bin/open5gs-upfd > /dev/null &

read -r -d '' _ < /dev/tty  # 'Locks' the script waiting for input
