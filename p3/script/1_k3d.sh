#!/bin/bash

# Run in first

sudo apt-get update
sudo apt install curl vim -qq -y

# # Install Docker
sudo apt-get install -y docker.io
sudo usermod -aG docker $USER

# # Install kubectl
# curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
# curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
# echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check

# sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# # Install K3D
# curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# # Clear installation files
# rm -f kubectl kubectl.sha256

# Delete cluster then recreate it
sudo k3d cluster delete dvergobbS
sudo k3d cluster create dvergobbS

# List mounted clusters
k3d cluster list
