#!/bin/bash

stop_all_child_jobs() {
    echo ""
    echo "Stopping open5gs daemons..."
    pkill -P $$
    echo "Open5gs jobs stopped"
}

trap stop_all_child_jobs EXIT SIGTERM SIGINT

# Start C-Plane processes
# add -c <config path> to specify the configs for each element
# e.g. /bin/open5gs-ausf -c /path/to/some/ausf_config > /dev/null &
/bin/open5gs-nrfd > /dev/null &
sleep 0.5
/bin/open5gs-scpd > /dev/null &
sleep 0.5
/bin/open5gs-amfd > /dev/null &
sleep 0.5
/bin/open5gs-smfd > /dev/null &
sleep 0.5
/bin/open5gs-ausfd > /dev/null &
sleep 0.5
/bin/open5gs-udmd > /dev/null &
sleep 0.5
/bin/open5gs-udrd > /dev/null &
sleep 0.5
/bin/open5gs-pcfd > /dev/null &
sleep 0.5
/bin/open5gs-nssfd > /dev/null &
sleep 0.5
/bin/open5gs-bsfd > /dev/null &



read -r -d '' _ < /dev/tty  # 'Locks' the script waiting for input
