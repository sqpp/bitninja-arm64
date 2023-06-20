
COLOR_LIGHT_RED='\e[1;31m'
COLOR_NC='\e[0m'
bind '"\t":complete' >/dev/null 2>&1


printf "[Installer]> Checking BitNinja Repository...\n"

# Check if the file exists
if [ -f "/etc/apt/sources.list.d/bitninja.list" ]; then
    
    # Check if the file contains the BitNinja Repo
    if grep -q "deb \[arch=amd64\] http://apt.bitninja.io/debian/ bitninja non-free" "/etc/apt/sources.list.d/bitninja.list"; then
        printf "[Installer]> [INFO] Repository already installed.\n"
        read -p "[Installer]> Do you want to install/update BitNinja? (y/n): " choice
        if [[ $choice =~ ^[Yy]$ ]]; then
            printf "\n[Installer]> [INFO] Running apt update...\n"
            install
        else
            printf "[Installer]> [INFO] Update skipped. Continuing with further actions...\n"
            exit 1
        fi
        # Continue with further actions here
    else
        printf "[Installer]> [ERROR] BitNinja Repository is missing from the bitninja.list\n"
        # Insert the BitNinja Repo
        printf "deb [arch=amd64] http://apt.bitninja.io/debian/ bitninja non-free" >> "/etc/apt/sources.list.d/bitninja.list"
        printf "[Installer]> [INFO] BitNinja Repo reconfigured and fixed, running apt update..\n"
        apt update
        # Ask the client if they want to proceed with the update
        read -p "[Installer]> Do you want to install/update BitNinja? (y/n): " choice
        if [[ $choice =~ ^[Yy]$ ]]; then
            printf "\n[Installer]> [INFO] Running apt update...\n"
            install
        else
            printf "[Installer]> [INFO] Update skipped. Continuing with further actions...\n"
            exit 1
        fi
    fi
else
    printf "[Installer]> [ERROR] The BitNinja Repository is not installed yet.\n"
    # Create the file and insert the BitNinja Repo
    printf "deb [arch=amd64] http://apt.bitninja.io/debian/ bitninja non-free" > "/etc/apt/sources.list.d/bitninja.list"
    
    printf "[Installer]> [INFO] BitNinja Repository is created, running apt update.\n"
    
    # Run apt update
    apt update
    read -p "[Installer]> Do you want to install/update BitNinja? (y/n): " choice
    if [[ $choice =~ ^[Yy]$ ]]; then
        printf "\n[Installer]> [INFO] Running apt update...\n"
        install
    else
        printf "[Installer]> [INFO] Update skipped. Continuing with further actions...\n"
        exit 1
    fi
fi



    cd /tmp
    printf "[Installer]> Downloading Prerequisites..."
    apt-get download bitninja-dojo:amd64 > /dev/null 2>&1
    apt-get download bitninja-python-dojo:amd64 > /dev/null 2>&1
    apt-get download bitninja-node-dojo:amd64 > /dev/null 2>&1
    apt-get download bitninja-ssl-termination:amd64 > /dev/null 2>&1
    apt-get download bitninja-dispatcher:amd64 > /dev/null 2>&1
    apt-get download bitninja-mq:amd64 > /dev/null 2>&1
    apt-get download bitninja-waf:amd64 > /dev/null 2>&1
    
    wget -q https://github.com/sqpp/bitninja-arm64/raw/main/bitninja-ssl-termination/haproxy
    wget -q https://github.com/sqpp/bitninja-arm64/raw/main/bitninja-mq/bitninja-mq-benchmark
    wget -q https://github.com/sqpp/bitninja-arm64/raw/main/bitninja-mq/bitninja-mq-cli
    wget -q https://github.com/sqpp/bitninja-arm64/raw/main/bitninja-mq/bitninja-mq-server
    wget -q https://github.com/sqpp/bitninja-arm64/raw/main/bitninja-node-dojo/node
    wget -q https://github.com/sqpp/bitninja-arm64/raw/main/bitninja-node-dojo/npm
    wget -q https://github.com/sqpp/bitninja-arm64/raw/main/bitninja-node-dojo/npx
    wget -q https://github.com/sqpp/bitninja-arm64/raw/main/bitninja-waf/nginx
    
    mkdir -p bitninja-dojo_arm64
    mkdir -p bitninja-python-dojo_arm64
    mkdir -p bitninja-node-dojo_arm64
    mkdir -p bitninja-ssl-termination_arm64
    mkdir -p bitninja-dispatcher_arm64
    mkdir -p bitninja-mq_arm64
    mkdir -p bitninja-waf_arm64
    
    mv bitninja-dojo_*amd64.deb bitninja-dojo_arm64
    mv bitninja-node-dojo_*amd64.deb bitninja-node-dojo_arm64
    mv bitninja-python-dojo_*amd64.deb bitninja-python-dojo_arm64
    mv bitninja-ssl-termination_*amd64.deb bitninja-ssl-termination_arm64
    mv bitninja-dispatcher_*amd64.deb bitninja-dispatcher_arm64
    mv bitninja-mq_*amd64.deb bitninja-mq_arm64
    mv bitninja-waf_*amd64.deb bitninja-waf_arm64
    
    printf "[Installer]> Configuring BitNinja Dojo..."
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
    
    printf "[BitNinja ARM64 Installer]> Configuring BitNinja Dispatcher..."
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
    
    printf "[Installer]> Configuring BitNinja Mq for Arm64..."
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
    printf "[Installer]> Configuring BitNinja Python Dojo for Arm64..."
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
    
    printf "[Installer]> Configuring BitNinja Node Dojo for Arm64..."
    
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
    
    printf "[Installer]> Installing BitNinja SSL Termination for WAF2.0..."
    
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
    
    printf "[Installer]> Installing BitNinja WAF2.0..."
    cd bitninja-waf_arm64
    ar x bitninja-waf_*amd64.deb > /dev/null 2>&1
    rm bitninja-waf_*amd64.deb
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
    ar r bitninja-waf_arm64.deb debian-binary control.tar.gz data.tar.gz > /dev/null 2>&1
    mv bitninja-waf_arm64.deb ..
    cd ..
    rm -Rf bitninja-waf_arm64
    sudo dpkg -i bitninja-waf_arm64.deb > /dev/null 2>&1
    
    
    printf "[Installer]> Downloading and Installing BitNinja form Arm64..."
    apt-get download bitninja:amd64 > /dev/null 2>&1
    mkdir bitninja_arm64
    mv bitninja_*amd64.deb bitninja_arm64
    cd bitninja_arm64
    printf "[Installer]> Extracting files..."
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
    read -e -p "[Installer]> PHP Binary: " -i "" phpbin
    printf "[Installer]> Installing/Updating BitNinja..."
    sudo dpkg -i bitninja_arm64.deb > /dev/null 2>&1
    printf "[Installer]> BitNinja installed and should be ready to use..."
    sudo sed -i "1 s\.*\#! "$phpbin" --php-ini=/opt/bitninja/etc/\1" /opt/bitninja/bitninja
    sudo sed -i "1 s\.*\#! "$phpbin" --php-ini=/opt/bitninja/etc/\1" /usr/sbin/bitninja-config
    sudo sed -i "1 s\.*\#! "$phpbin" --php-ini=/opt/bitninja/etc/\1" /usr/sbin/bitninjacli
    sudo sed -i '$ a extension=curl.so' /opt/bitninja/etc/php.ini
    
    cp -R /tmp/node /tmp/npx /tmp/npm /opt/bitninja-node-dojo/bin
    cp -R /tmp/bitninja-mq-cli /tmp/bitninja-mq-server /tmp/bitninja-mq-benchmark /opt/bitninja-mq/bin
    cp -R /tmp/haproxy /opt/bitninja-ssl-termination/sbin/bitninja-sslt
    cp -R /tmp/bitninja-waf/sbin/nginx /opt/bitninja-waf/sbin/nginx
    printf "[Installer]> Patching Node Dojo, SSLTermination, MQ and BitNinja WAF..."
    
    printf "[Installer]> DO NOT FORGET TO PROVIDE LICENSE"
    printf "[Installer]> bitninja-config --set license_key=<key>"
    printf "[Installer]> Restarting bitninja... "
    sudo systemctl restart bitninja.service
    
