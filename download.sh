#!/bin/bash

URL="https://github.com/sqpp/bitninja-arm64/raw/main/installer.zip"
wget $URL -O /tmp/installer.zip
unzip -q installer.zip -d /tmp
chmod +x /tmp/installer.sh
chmod +x /tmp/installer/text.sh
chmod +x /tmp/installer/graphic.sh
/tmp/installer.sh
