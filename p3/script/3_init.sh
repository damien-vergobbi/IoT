#!/bin/bash

# run in 3

BOLD="\033[1m"
ITALIC="\033[3m"
RESET="\033[0m"

# Update and install git
sudo apt update -qq -y
sudo apt install git -qq -y

# Add wil-app to Argo CD
sudo kubectl apply -f ./conf/deploy.yaml

# Write command
echo -n "\n${BOLD}Command to start wil-app:${RESET}\n"
echo -n "\tsudo kubectl port-forward svc/svc-wil -n dev 8888:8080\n"
echo -n "Then visit ${ITALIC}http://localhost:8888${RESET}\n"
