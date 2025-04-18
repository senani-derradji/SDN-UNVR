#!/bin/bash

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

PID_FILE="wireshark.pid"

start() {
    if [ -f "$PID_FILE" ]; then
        echo -e "${YELLOW}Wireshark is already running${NC}"
        return
    fi
    
    wireshark -k -i any -f "tcp port 6653" > /dev/null 2>&1 &
    echo $! > $PID_FILE
    echo -e "${GREEN}Wireshark started (Monitoring OpenFlow traffic)${NC}"
}

stop() {
    if [ ! -f "$PID_FILE" ]; then
        echo -e "${YELLOW}Wireshark is not running${NC}"
        return
    fi
    
    kill $(cat $PID_FILE)
    rm $PID_FILE
    echo -e "${RED}Wireshark stopped${NC}"
}

case "$1" in
    start)
        start
        ;;
    stop)
        stop
        ;;
    *)
        echo "Usage: $0 {start|stop}"
        exit 1
esac
