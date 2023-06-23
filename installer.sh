#!/bin/bash

COLOR_LIGHT_RED='\e[1;31m'
COLOR_NC='\e[0m'



check_arm64() {
    arch=$(uname -m)
    # Check if the machine is running on ARM64
    if [ "$arch" = "aarch64" ]; then
        echo "Yes - Supported"
    else
        echo "NO - Good bye."
        exit 1
    fi
}

# Function to check if the machine is Raspberry Pi 3B or 4 with at least 4 GB of RAM
check_raspberry_pi() {
    # Check if the machine is Raspberry Pi
    if [ ! -f /proc/device-tree/model ]; then
        echo "This machine is not a Raspberry Pi."
        return 1
    fi

    # Get the Raspberry Pi model
    model=$(tr -d '\0' </proc/device-tree/model)

    # Check if the model matches Raspberry Pi 3B or 4
    if [[ $model != *"Raspberry Pi 3"* && $model != *"Raspberry Pi 4"* ]]; then
        echo "This machine is not a Raspberry Pi 3B or 4."
        return 1
    fi

    # Get the RAM size
    ram=$(awk '/MemTotal/ {print $2}' /proc/meminfo)

    # Check if the RAM size is at least 4 GB
    if [ "$ram" -lt 4000000 ]; then
        echo "This Raspberry Pi has less than 4 GB of RAM."
        return 1
    fi

    echo "Model: ${model}"
    return 0
}

function guiUsable() {
    # Check if whiptail is installed
    if ! command -v whiptail >/dev/null 2>&1; then
        echo "whiptail is not installed. Installing..."
        
        # Install whiptail
        sudo apt-get install -y whiptail
        
        # Check if installation was successful
        if [ $? -ne 0 ]; then
            echo "Failed to install whiptail. Exiting..."
            return 1  # Return an error code
        fi
        
        echo "whiptail has been installed successfully."
    fi
    
    # Check if text.sh exists
    if [ -f "./installer/text.sh" ]; then
        echo "Yes"
    else
        echo "No"
    fi
}

# Function to output installer details
output_installer_details() {
    printf "\n\n${COLOR_LIGHT_RED}______ _ _   _   _ _       _          ___                  ____    ___\n";
    printf "| ___ (_) | | \ | (_)     (_)        / _ \                / ___|  /   |\n";
    printf "| |_/ /_| |_|  \| |_ _ __  _  __ _  / /_\ \_ __ _ __ ___ / /___  / /| |\n";
    printf "| ___ \ | __| . . | | '_ \| |/ _. | |  _  | '__| '_ ' _ \| ___ \/ /_| |\n";
    printf "| |_/ / | |_| |\  | | | | | | (_| | | | | | |  | | | | | | \_/ |\___  |\n";
    printf "\____/|_|\__\_| \_/_|_| |_| |\__,_| \_| |_/_|  |_| |_| |_\_____/    |_/\n";
    printf "                         _/ |\n";
    printf "                        |__/${COLOR_NC}\n\n";
    echo "##################################################################"
    echo -e "\nWelcome to the BitNinja for Linux ARM64 client installer!"
    echo -e "If you encounter any errors, please open a GitHub issue."
    echo -e "https://github.com/sqpp/bitninjarm64\n"
    echo "##################################################################"
    echo "Installer Details:"
    echo "------------------"
    echo "Operating System: $(lsb_release -sd)"
     # Check if the machine is Raspberry Pi
    echo "ARM64: $(check_arm64)"
    check_raspberry_pi
    echo "GUI Setup Supported: $(guiUsable)"
    echo "------------------"
}

function run_install() {
# Check if the OS is Ubuntu
if [ "$(lsb_release -si)" != "Ubuntu" ]; then
    echo "This script is intended for Ubuntu only. Exiting..."
    exit 1
fi

# Check the Ubuntu version
required_version="18.04"
current_version=$(lsb_release -sr)

if [[ $(echo "$current_version >= $required_version" | bc -l) -eq 0 ]]; then
    echo "This script requires at least Ubuntu $required_version. Exiting..."
    exit 1
fi

# Parse command line arguments
while getopts "d" opt; do
    case $opt in
        d)
            debug_mode=true
        ;;
        *)
            echo "Invalid option: -$OPTARG"
            exit 1
        ;;
    esac
done


}


# Check if sudo was used
if [ "$UID" -eq 0 ]; then
    output_installer_details
        
    # Prompt for installer choice
    echo "Please select the installer:"
    echo "1. GUI Installer"
    echo "2. Text Installer"
    read -p "[Installer]> Choice: " installer_choice
    case $installer_choice in
        1)
            ./installer/graphic.sh
        ;;
        2)
            ./installer/text.sh
        ;;
        *)
            echo "Invalid choice. Exiting..."
            exit 1
        ;;
    esac
   
else
    echo "[ERROR] Please run it with sudo"
    exit 1
fi

