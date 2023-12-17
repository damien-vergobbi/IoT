#!/bin/sh

# curl -sfL https://get.k3s.io | sh -s - server --flannel-iface=eth1
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--write-kubeconfig-mode 644" sh -
sudo cp /var/lib/rancher/k3s/server/node-token /vagrant_shared/node-token
sudo apt-get update
sudo apt-get install -y net-tools
