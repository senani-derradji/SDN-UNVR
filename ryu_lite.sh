#!/bin/bash

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# No sudo needed here - Ryu doesn't require root privileges
if [ -f "RYU-ENV/bin/activate" ]; then
    . RYU-ENV/bin/activate  # Using dot (.) instead of source
    echo -e "${GREEN}Virtual environment activated${NC}"
else
    echo -e "${RED}Error: Virtual environment not found${NC}"
    exit 1
fi

# Check if requirements are installed
if ! pip show ryu &> /dev/null; then
    echo -e "${RED}Error: Ryu is not installed in the virtual environment${NC}"
    exit 1
fi

# Run Ryu controller
echo -e "${GREEN}Starting Ryu controller...${NC}"
ryu-manager --verbose --ofp-tcp-listen-port=6653 ryu.app.simple_switch_13
