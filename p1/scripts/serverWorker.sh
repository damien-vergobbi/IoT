#!/bin/sh

# Token is in `sudo cat /var/lib/rancher/k3s/server/node-token`
curl -sfL https://get.k3s.io | K3S_URL=https://192.168.42.110:6443 K3S_TOKEN=`cat /vagrant_shared/node-token` sh -s - --flannel-iface=eth1
sudo apt-get update
sudo apt-get install -y net-tools
