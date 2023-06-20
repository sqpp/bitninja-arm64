#!/bin/bash

URL="https://github.com/sqpp/bitninja-arm64/raw/main/installer.zip"
cd /tmp
wget $URL
unzip /tmp/installer.zip
chmod +x /tmp/installer.sh /tmp/installer/text.sh /tmp/installer/graphic.sh
/tmp/installer.sh