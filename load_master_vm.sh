#!/bin/bash

# Mise à jour des paquets
sudo apt-get update

# Installation des outils de base
sudo apt-get install -qqy wget curl vim net-tools

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
rm kubectl

# Vérification de l'installation de Vagrant
if ! dpkg -l | grep -q vagrant
then
    # Installation de VirtualBox
    sudo apt-get install -y virtualbox

    # Téléchargement de Vagrant
    wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
    sudo apt update && sudo apt install vagrant

    # Vérification de l'installation de Vagrant
    vagrant --version
fi

# Vérification de l'installation de Docker
if ! dpkg -l | grep -q docker
then
    # Installation de Docker
    sudo apt-get install -y docker.io

    # Ajouter l'utilisateur à groupe docker pour éviter l'utilisation de sudo
    sudo usermod -aG docker $USER
fi

# Vérification de l'installation de K3D
if ! command -v k3d &> /dev/null
then
    # Installation de K3D
    wget -q -O - https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
fi

# Vérification de l'installation d'Argo CD
if ! command -v argocd &> /dev/null
then
    # Installation d'Argo CD
    sudo kubectl create namespace argocd
    sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

fi

# Install Helm
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash
