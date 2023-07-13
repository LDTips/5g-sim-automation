#!/bin/bash

stop_child_processes() {
    echo ""
    echo "Stopping jobs..."
    pkill -P $$
    echo "Jobs stopped"
}

trap stop_child_processes EXIT SIGTERM SIGINT

# Start background processes
yes > /dev/null &
yes > /dev/null &

echo "Started scripts..."

read -r -d '' _ < /dev/tty  # 'Locks' the script waiting for input
