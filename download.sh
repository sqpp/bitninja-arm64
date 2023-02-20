#!/bin/bash

COLOR_LIGHT_RED='\e[1;31m'
COLOR_NC='\e[0m'
bind '"\t":complete' >/dev/null 2>&1


printf "\n\n"; 
printf "${COLOR_LIGHT_RED}______ _ _   _   _ _       _          ___                  ____    ___\n"; 
printf "| ___ (_) | | \ | (_)     (_)        / _ \                / ___|  /   |\n"; 
printf "| |_/ /_| |_|  \| |_ _ __  _  __ _  / /_\ \_ __ _ __ ___ / /___  / /| |\n"; 
printf "| ___ \ | __| . . | | '_ \| |/ _. | |  _  | '__| '_ ' _ \| ___ \/ /_| |\n"; 
printf "| |_/ / | |_| |\  | | | | | | (_| | | | | | |  | | | | | | \_/ |\___  |\n"; 
printf "\____/|_|\__\_| \_/_|_| |_| |\__,_| \_| |_/_|  |_| |_| |_\_____/    |_/\n"; 
printf "                         _/ |\n";
printf "                        |__/${COLOR_NC}\n";
    printf "Welcome to the BitNinja form linux ARM64 client installer!\n";
    printf "If you encounter any error, open a github issue.\n";
    printf "https//github.com/sqpp/bitninjarm64\n\n\n";

cd /tmp
echo "[BitNinja ARM64 Installer]> Downloading Prerequisites..."
apt-get download bitninja-dojo:amd64 > /dev/null 2>&1
apt-get download bitninja-python-dojo:amd64 > /dev/null 2>&1
apt-get download bitninja-node-dojo:amd64 > /dev/null 2>&1
apt-get download bitninja-ssl-termination:amd64 > /dev/null 2>&1
apt-get download bitninja-dispatcher:amd64 > /dev/null 2>&1
apt-get download bitninja-mq:amd64 > /dev/null 2>&1

wget -q https://github.com/sqpp/bitninja-arm64/raw/main/bitninja-ssl-termination/haproxy
wget -q https://github.com/sqpp/bitninja-arm64/raw/main/bitninja-mq/bitninja-mq-benchmark
wget -q https://github.com/sqpp/bitninja-arm64/raw/main/bitninja-mq/bitninja-mq-cli
wget -q https://github.com/sqpp/bitninja-arm64/raw/main/bitninja-mq/bitninja-mq-server
wget -q https://github.com/sqpp/bitninja-arm64/raw/main/bitninja-node-dojo/node
wget -q https://github.com/sqpp/bitninja-arm64/raw/main/bitninja-node-dojo/npm
wget -q https://github.com/sqpp/bitninja-arm64/raw/main/bitninja-node-dojo/npx

mkdir -p bitninja-dojo_arm64
mkdir -p bitninja-python-dojo_arm64
mkdir -p bitninja-node-dojo_arm64
mkdir -p bitninja-ssl-termination_arm64
mkdir -p bitninja-dispatcher_arm64
mkdir -p bitninja-mq_arm64

mv bitninja-dojo_*amd64.deb bitninja-dojo_arm64
mv bitninja-node-dojo_*amd64.deb bitninja-node-dojo_arm64
mv bitninja-python-dojo_*amd64.deb bitninja-python-dojo_arm64
mv bitninja-ssl-termination_*amd64.deb bitninja-ssl-termination_arm64
mv bitninja-dispatcher_*amd64.deb bitninja-dispatcher_arm64
mv bitninja-mq_*amd64.deb bitninja-mq_arm64

echo "[BitNinja ARM64 Installer]> Configuring BitNinja Dojo..."
cd bitninja-dojo_arm64
ar x bitninja-dojo_*amd64.deb > /dev/null 2>&1
rm bitninja-dojo_*amd64.deb
mkdir -p control
mv control.tar.gz control/
cd control
tar -zxf control.tar.gz > /dev/null
rm control.tar.gz
sed -i "5s/Architecture: amd64/Architecture: arm64/1" control
tar czf control.tar.gz * > /dev/null
mv control.tar.gz ..
cd ..
rm -r control
ar r bitninja-dojo_arm64.deb debian-binary control.tar.gz data.tar.gz > /dev/null 2>&1
mv bitninja-dojo_arm64.deb ..
cd ..
rm -Rf bitninja-dojo_arm64
sudo dpkg -i bitninja-dojo_arm64.deb > /dev/null 

## BitNinja Dispatcher Arm64

echo "[BitNinja ARM64 Installer]> Configuring BitNinja Dispatcher..."
cd bitninja-dispatcher_arm64
ar x bitninja-dispatcher_*amd64.deb > /dev/null
rm bitninja-dispatcher_*amd64.deb
mkdir -p control
mv control.tar.gz control/
cd control
tar -zxf control.tar.gz > /dev/null
rm control.tar.gz
sed -i "5s/Architecture: amd64/Architecture: arm64/1" control
tar czf control.tar.gz * > /dev/null
mv control.tar.gz ..
cd ..
rm -r control
ar r bitninja-dispatcher_arm64.deb debian-binary control.tar.gz data.tar.gz > /dev/null 2>&1
mv bitninja-dispatcher_arm64.deb ..
cd ..
rm -Rf bitninja-dispatcher_arm64
sudo dpkg -i bitninja-dispatcher_arm64.deb > /dev/null


## BitNinja Mq Arm64

echo "[BitNinja ARM64 Installer]> Configuring BitNinja Mq for Arm64..."
cd bitninja-mq_arm64
ar x bitninja-mq_*amd64.deb > /dev/null
rm bitninja-mq_*amd64.deb
mkdir -p control
mv control.tar.gz control/
cd control
tar -zxf control.tar.gz > /dev/null
rm control.tar.gz
sed -i "5s/Architecture: amd64/Architecture: arm64/1" control
tar czf control.tar.gz * > /dev/null
mv control.tar.gz ..
cd ..
rm -r control
ar r bitninja-mq_arm64.deb debian-binary control.tar.gz data.tar.gz > /dev/null 2>&1
mv bitninja-mq_arm64.deb ..
cd ..
rm -Rf bitninja-mq_arm64
sudo dpkg -i bitninja-mq_arm64.deb > /dev/null

## BitNinja Python Dojo
echo "[BitNinja ARM64 Installer]> Configuring BitNinja Python Dojo for Arm64..."
cd bitninja-python-dojo_arm64
ar x bitninja-python-dojo_*amd64.deb > /dev/null
rm bitninja-python-dojo_*amd64.deb
mkdir -p control
mv control.tar.gz control/
cd control
tar -zxf control.tar.gz > /dev/null
rm control.tar.gz
sed -i "5s/Architecture: amd64/Architecture: arm64/1" control
tar czf control.tar.gz * > /dev/null
mv control.tar.gz ..
cd ..
rm -r control
ar r bitninja-python-dojo_arm64.deb debian-binary control.tar.gz data.tar.gz > /dev/null 2>&1
mv bitninja-python-dojo_arm64.deb ..
cd ..
rm -Rf bitninja-python-dojo_arm64
sudo dpkg -i bitninja-python-dojo_arm64.deb > /dev/null 2>&1

echo "[BitNinja ARM64 Installer]> Configuring BitNinja Node Dojo for Arm64..."

cd bitninja-node-dojo_arm64
ar x bitninja-node-dojo_*amd64.deb > /dev/null
rm bitninja-node-dojo_*amd64.deb
mkdir -p control
mv control.tar.gz control/
cd control
tar -zxf control.tar.gz > /dev/null
rm control.tar.gz
sed -i "5s/Architecture: amd64/Architecture: arm64/1" control
tar czf control.tar.gz * > /dev/null
mv control.tar.gz ..
cd ..
rm -r control
ar r bitninja-node-dojo_arm64.deb debian-binary control.tar.gz data.tar.gz > /dev/null 2>&1
mv bitninja-node-dojo_arm64.deb ..
cd ..
rm -Rf bitninja-node-dojo_arm64
sudo dpkg -i bitninja-node-dojo_arm64.deb > /dev/null 2>&1


echo "[BitNinja ARM64 Installer]> Installing BitNinja SSL Termination for WAF2.0..."

cd bitninja-ssl-termination_arm64
ar x bitninja-ssl-termination_*amd64.deb > /dev/null 2>&1
rm bitninja-ssl-termination_*amd64.deb
mkdir control
mv control.tar.gz control/
cd control
tar -zxf control.tar.gz > /dev/null
rm control.tar.gz
sed -i "5s/Architecture: amd64/Architecture: arm64/1" control
tar czf control.tar.gz * > /dev/null
mv control.tar.gz ..
cd ..
rm -r control
ar r bitninja-ssl-termination_arm64.deb debian-binary control.tar.gz data.tar.gz > /dev/null 2>&1
mv bitninja-ssl-termination_arm64.deb ..
cd ..
rm -Rf bitninja-ssl-termination_arm64
sudo dpkg -i bitninja-ssl-termination_arm64.deb > /dev/null 2>&1

echo "[BitNinja ARM64 Installer]> Downloading and Installing BitNinja form Arm64..."
apt-get download bitninja:amd64 > /dev/null 2>&1
mkdir bitninja_arm64
mv bitninja_*amd64.deb bitninja_arm64
cd bitninja_arm64
echo "[BitNinja ARM64 Installer]> Extracting files..."
ar x bitninja_*amd64.deb > /dev/null
rm bitninja_*amd64.deb
mkdir control
mv control.tar.gz control/
cd control
tar -zxf control.tar.gz > /dev/null
rm control.tar.gz
sed -i "5s/Architecture: amd64/Architecture: arm64/1" control
tar czf control.tar.gz * > /dev/null
mv control.tar.gz ..
cd ..
rm -r control
ar r bitninja_arm64.deb debian-binary control.tar.gz data.tar.gz > /dev/null 2>&1
mv bitninja_arm64.deb ..
cd ..
rm -Rf bitninja_arm64
read -e -p "[BitNinja ARM64 Installer]> PHP Binary: " -i "" phpbin
echo "[BitNinja ARM64 Installer]> Installing/Updating BitNinja..."
sudo dpkg -i bitninja_arm64.deb > /dev/null 2>&1
echo "[BitNinja ARM64 Installer]> BitNinja installed and should be ready to use..."
sudo sed -i "1 s\.*\#! "$phpbin" --php-ini=/opt/bitninja/etc/\1" /opt/bitninja/bitninja
sudo sed -i "1 s\.*\#! "$phpbin" --php-ini=/opt/bitninja/etc/\1" /usr/sbin/bitninja-config
sudo sed -i "1 s\.*\#! "$phpbin" --php-ini=/opt/bitninja/etc/\1" /usr/sbin/bitninjacli

cp -R node npx npm /opt/bitninja-node-dojo
cp -R bitninja-mq-cli bitninja-mq-server bitninja-mq-benchmark /opt/bitninja-mq/bin
cp -R haproxy /opt/bitninja-ssl-termination/sbin/bitninja-sslt

echo "[BitNinja ARM64 Installer]> Patching Node Dojo, SSLTermination, MQ..."

echo "DO NOT FORGET TO PROVIDE LICENSE"
echo "bitninja-config --set license_key=<key>"

