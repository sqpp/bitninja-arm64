#!/bin/bash

URL="https://github.com/sqpp/bitninja-arm64/raw/main/installer.zip"
cd /tmp
wget $URL -o /tmp/installer.zip
unzip /tmp/installer.zip
chmod +x /tmp/installer.sh
chmod +x /tmp/installer/text.sh
chmod +x /tmp/installer/graphic.sh
/tmp/installer.sh