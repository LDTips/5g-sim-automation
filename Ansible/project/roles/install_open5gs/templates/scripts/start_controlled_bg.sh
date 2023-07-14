#!/bin/bash

stop_all_child_jobs() {
    echo ""
    echo "Stopping open5gs daemons..."
    pkill -P $$
    echo "Open5gs jobs stopped"
}

trap stop_all_child_jobs EXIT SIGTERM SIGINT

# Start background processes
/bin/open5gs-nrfd > /dev/null &
sleep 1
/bin/open5gs-scpd > /dev/null &
sleep 1
/bin/open5gs-amfd > /dev/null &
sleep 1
/bin/open5gs-smfd > /dev/null &
sleep 1
/bin/open5gs-ausfd > /dev/null &
sleep 1
/bin/open5gs-udmd > /dev/null &
sleep 1
/bin/open5gs-udrd > /dev/null &
sleep 1
/bin/open5gs-pcfd > /dev/null &
sleep 1
/bin/open5gs-nssfd > /dev/null &
sleep 1
/bin/open5gs-bsfd > /dev/null &
sleep 1
/bin/open5gs-upfd > /dev/null &

echo "Simulator daemons started. Send termination signal to end..."

read -r -d '' _ < /dev/tty  # 'Locks' the script waiting for input
