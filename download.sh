#!/bin/bash

URL="https://github.com/sqpp/bitninja-arm64/raw/main/installer.zip"
cd /tmp
wget $URL -O installer.zip
unzip -oq installer.zip
chmod +x installer.sh
chmod +x installer/text.sh
chmod +x installer/graphic.sh
./installer.sh
