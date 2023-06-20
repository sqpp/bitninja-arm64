#!/bin/bash

URL="https://github.com/sqpp/bitninja-arm64/raw/main/installer.zip"
temp_dir=$(mktemp -d)

# Download the installer.zip file
if command -v curl >/dev/null 2>&1; then
    curl -o "$temp_dir/files.tar.gz" "$URL";
elif command -v wget >/dev/null 2>&1; then
    wget -q "$URL" -O "$temp_dir/files.tar.gz"
else
    echo "Error: Could not find suitable program to download the installer. Please install either curl or wget."
    exit 1
fi

# Print the contents of the temporary directory
ls -l "$temp_dir"

tar -xf "$temp_dir/files.tar.gz" -C "$temp_dir"

# Set the correct installer directory path
installer_dir="$temp_dir/installer"

# Print the contents of the installer directory
ls -l "$installer_dir"

# Set permissions for the installer.sh and other scripts
chmod +x "$installer_dir/installer.sh"
chmod +x "$installer_dir/text.sh"
chmod +x "$installer_dir/graphic.sh"

# Run the installer.sh script
"$installer_dir/installer.sh"
