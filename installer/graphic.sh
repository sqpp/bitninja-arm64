#!/bin/bash

# Check if the OS is Ubuntu
if [ "$(lsb_release -si)" != "Ubuntu" ]; then
    echo "BitNinja for Arm64 is only supported on Ubuntu dist. Exiting..."
    exit 1
fi

# Check the Ubuntu version
required_version="18.04"
current_version=$(lsb_release -sr)

if [[ $(echo "$current_version >= $required_version" | bc -l) -eq 0 ]]; then
    echo "This script requires at least Ubuntu $required_version. Exiting..."
    exit 1
fi

# Check if whiptail is installed
if ! command -v whiptail >/dev/null 2>&1; then
    echo "whiptail is not installed. Installing..."
    
    # Install whiptail
    sudo apt-get install -y whiptail
    
    # Check if installation was successful
    if [ $? -ne 0 ]; then
        echo "Failed to install whiptail. Exiting..."
        exit 1
    fi
    
    echo "whiptail has been installed successfully."
fi

# Rest of your code
