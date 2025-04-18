#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Install figlet if not exists
if ! command -v figlet &> /dev/null; then
    sudo apt install -y figlet
fi

sudo apt install lolcat -y
clear
figlet -f slant "SDN Controller Setup" | lolcat
echo -e "${YELLOW}         S A L A M ${NC}"
echo -e "${YELLOW}Created by Derradji Senani${NC}"
echo -e "${BLUE}========================================${NC}"
echo

# Function to display status
status() {
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}[✓] $1${NC}"
    else
        echo -e "${RED}[✗] $1${NC}"
        exit 1
    fi
}

# Function to run command in new terminal
run_in_new_terminal() {
    local title="$1"
    local command="$2"
    gnome-terminal --title="$title" -- bash -c "$command; exec bash"
}

# Install Ryu Controller
install_ryu() {
    echo -e "${BLUE}[+] Installing Ryu Controller...${NC}"
    sudo add-apt-repository ppa:deadsnakes/ppa -y
    sudo apt update
    sudo apt install python3.9 python3-pip python3-dev libssl-dev libffi-dev python3.9-venv -y
    python3.9 -m venv RYU-ENV-3.9
    source ./RYU-ENV-3.9/bin/activate
    pip install -r ./RYU-ENV/requirements.txt
    status "Ryu installation completed"
}

# Install OVS and Mininet
install_ovs_mininet() {
    echo -e "${BLUE}[+] Installing Open vSwitch and Mininet...${NC}"
    sudo apt update
    sudo apt install -y openvswitch-switch openvswitch-common
    sudo systemctl start openvswitch-switch
    sudo systemctl enable openvswitch-switch
    sudo apt install -y mininet
    status "OVS and Mininet installation completed"
}

# Install Wireshark
install_wireshark() {
    echo -e "${BLUE}[+] Installing Wireshark...${NC}"
    sudo apt install -y wireshark
    sudo usermod -aG wireshark $USER
    status "Wireshark installation completed"
}

# Main installation
install_all() {
    install_ryu
    install_ovs_mininet
    install_wireshark
    
    # Make scripts executable
    chmod +x ryu_control.sh
    chmod +x ovs_mininet.sh
    chmod +x wireshark_monitor.sh
    
    echo -e "${GREEN}\n[+] All components installed successfully!${NC}"
    echo -e "${YELLOW}You can now manage each component using:${NC}"
    echo -e "  ./ryu_control.sh [start|stop|status]"
    echo -e "  ./ovs_mininet.sh [start|stop|status]"
    echo -e "  ./wireshark_monitor.sh [start|stop]"
}

# Start all services in separate terminals
start_all() {
    echo -e "${GREEN}[+] Starting all services in separate terminals...${NC}"
    
    # Start Ryu Controller
    run_in_new_terminal "Ryu Controller" "cd $(pwd); ./ryu_lite.sh"
    
    # Start Mininet
    run_in_new_terminal "Mininet" "cd $(pwd); sudo mn --controller=remote,ip=127.0.0.1 --switch=ovsk,protocols=OpenFlow13"
    
    # Start Wireshark
    run_in_new_terminal "Wireshark" "cd $(pwd); sudo wireshark -k -i any -f 'tcp port 6653'"
    
    echo -e "${GREEN}[✓] All services started in separate windows${NC}"
}

# Menu
PS3='Please enter your choice: '
options=("Install All Components" "Start All Services" "Exit")
select opt in "${options[@]}"
do
    case $opt in
        "Install All Components")
            install_all
            ;;
        "Start All Services")
            start_all
            ;;
        "Exit")
            break
            ;;
        *) echo "Invalid option $REPLY";;
    esac
done
