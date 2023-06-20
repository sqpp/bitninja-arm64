#!/bin/bash

URL="https://github.com/sqpp/bitninja-arm64/raw/main/installer.zip"
wget $URL -O /tmp/installer.zip
unzip -oq /tmp/installer.zip
chmod +x /tmp/installer.sh
chmod +x /tmp/installer/text.sh
chmod +x /tmp/installer/graphic.sh
./tmp/installer.sh
rm -rf /tmp/installer*