#!/bin/bash

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

PID_FILE="mininet.pid"

start() {
    if [ -f "$PID_FILE" ]; then
        echo -e "${YELLOW}Mininet is already running${NC}"
        return
    fi
    
    gnome-terminal --title="Mininet Console" -- bash -c "sudo mn --controller=remote,ip=127.0.0.1 --switch=ovsk,protocols=OpenFlow13; exec bash" &
    echo $! > $PID_FILE
    echo -e "${GREEN}Mininet started${NC}"
}

stop() {
    if [ ! -f "$PID_FILE" ]; then
        echo -e "${YELLOW}Mininet is not running${NC}"
        return
    fi
    
    sudo mn -c
    kill $(cat $PID_FILE)
    rm $PID_FILE
    echo -e "${RED}Mininet stopped${NC}"
}

status() {
    if [ -f "$PID_FILE" ] && ps -p $(cat $PID_FILE) > /dev/null; then
        echo -e "${GREEN}Mininet is running${NC}"
    else
        echo -e "${RED}Mininet is not running${NC}"
    fi
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    status)
        status
        ;;
    *)
        echo "Usage: $0 {start|stop|status}"
        exit 1
esac
