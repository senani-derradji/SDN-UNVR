#!/bin/bash

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

RYU_ENV="RYU-ENV"
RYU_APP="ryu.app.simple_switch_13"
LOG_FILE="ryu.log"
PID_FILE="ryu.pid"

start() {
    if [ -f "$PID_FILE" ]; then
        echo -e "${YELLOW}Ryu controller is already running${NC}"
        return
    fi
    
    source ./RYU-ENV/bin/activate
#    nohup ryu-manager --verbose --log-file=$LOG_FILE --ofp-tcp-listen-port=6653 $RYU_APP > /dev/null 2>&1 &
    ryu-manager --verbose ryu.app.simple_switch_13
    echo $! > $PID_FILE
    echo -e "${GREEN}Ryu controller started${NC}"
}

stop() {
    if [ ! -f "$PID_FILE" ]; then
        echo -e "${YELLOW}Ryu controller is not running${NC}"
        return
    fi
    
    kill $(cat $PID_FILE)
    rm $PID_FILE
    echo -e "${RED}Ryu controller stopped${NC}"
}

status() {
    if [ -f "$PID_FILE" ] && ps -p $(cat $PID_FILE) > /dev/null; then
        echo -e "${GREEN}Ryu controller is running${NC}"
    else
        echo -e "${RED}Ryu controller is not running${NC}"
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
