#!/bin/bash

# Run in second

BOLD="\033[1m"
GREEN="\033[32m"
RED="\033[31m"
RESET="\033[0m"

# Delete namespaces then recreate it
sudo kubectl delete namespace argocd
sudo kubectl delete namespace dev

sudo kubectl create namespace argocd
sudo kubectl create namespace dev

# Install Argo CD in kubectl
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Add host in VM hosts if not exists
HOST_ENTRY="127.0.0.1 argocd.dvergobb.com"
HOSTS_FILE="/etc/hosts"

if grep -q "$HOST_ENTRY" "$HOSTS_FILE"; then
    echo "exist $HOSTS_FILE"
else
    echo "adding $HOSTS_FILE"
    echo "$HOST_ENTRY" | sudo tee -a "$HOSTS_FILE"
fi

# waitpod
sudo kubectl wait --for=condition=ready --timeout=600s pod --all -n argocd

# password to argocd (user: admin)
echo -n "\n${BOLD}${GREEN}Argo CD username :${RESET}${GREEN} admin${RESET}\n"
echo -n "${BOLD}${GREEN}Argo CD password :${RESET}${GREEN} "
  sudo kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 --decode
echo "${RESET}"

# Start Argo CD on localhost:8085 or argocd.dvergobb.com:8085
sudo kubectl port-forward svc/argocd-server -n argocd 8085:443 > /dev/null 2>&1 &
