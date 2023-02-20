# BitNinja for Arm64

## Description

BitNinja for Arm64, mainly focusing on Raspberry 4 (4GB and up)

## Installation

Important: Make sure during the installation you provide the executable binary for PHP.

Assume you have already installed the extensions `ahocorasick.so`, `ctype.so`, `ast.so`, `inotify.so`, `redis.so`, `pdo_sqlite`
Most of these available for installation using `pecl`, but some of them have to be built manually.

```bash
git clone https://github.com/sqpp/bitninja-arm64
cd bitninja-arm64
sudo chmod a+x download.sh
sudo ./download.sh
```

## Issues

In case you want to use the WAF for SSLTermination (which is haproxy), copy the `haproxy` binary and move it to `/opt/bitninja-ssl-termination-sbin` as filename `bitninja-sslt`

`cp haproxy /opt/bitninja-ssl-termination/sbin/bitninja-sslt`

Additionally, note that you might need to install redis 7.0.3 and nodejs 10.24.1 as well. These are included in the repo as a bianry. 

-- These eventually will be also included in the script, so you don't have to deal with it.

Any problems? Report!
