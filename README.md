# BitNinja for Arm64

## Description

BitNinja for Arm64, mainly focusing on Raspberry 4 (4GB and up)

## Installation

Important: Make sure during the installation you provide the executable binary for PHP.

Assume you have already installed the extensions `ahocorasick.so`, `ctype.so`, `ast.so`, `inotify.so`, `redis.so`, `pdo_sqlite`
Most of these available for installation using `pecl`, but some of them have to be built manually.

```bash
sudo wget https://github.com/sqpp/bitninja-arm64/blob/main/download.sh
sudo chmod a+x download.sh
sudo ./download.sh
```

## Issues

You might also need to add curl.so to the BitNinja php.ini in /opt/bitninja/etc/php.ini

`extension=curl.so`

Any problems? Report!
