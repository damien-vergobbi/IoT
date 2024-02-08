#!/bin/bash

if [ "$(id -u)" != "0" ]
then
    echo "Permission denied ; please run as sudo"
    exit 0
fi

if grep "app[1-3].com" /etc/hosts > /dev/null 2>&1
then
    echo "At least one host is already set"
    exit 0
fi

cat >> /etc/hosts << EOF
192.168.56.110 app1.com
192.168.56.110 app2.com
EOF

echo "Hosts successfully added"