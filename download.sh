#!/bin/bash

URL="https://github.com/sqpp/bitninja-arm64/raw/main/files.tar.gz"
temp_dir=$(mktemp -d)

# Download the installer.zip file
if command -v curl >/dev/null 2>&1; then
    cd $temp_dir && curl -L $URL | tar zx
    echo "Downloaded file size: $file_size bytes"
elif command -v wget >/dev/null 2>&1; then
    wget -q "$URL" -O "$temp_dir/files.tar.gz"
else
    echo "Error: Could not find suitable program to download the installer. Please install either curl or wget."
    exit 1
fi

# Set the correct installer directory path
installer_dir="$temp_dir"

# Set permissions for the installer.sh and other scripts
chmod +x "$installer_dir/installer.sh"
chmod +x "$installer_dir/installer/text.sh"
chmod +x "$installer_dir/installer/graphic.sh"

# Run the installer.sh script
"$installer_dir/installer.sh"
