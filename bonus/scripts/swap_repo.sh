#!/bin/bash

BOLD="\033[1m"
ITALIC="\033[3m"
GREEN="\033[32m"
RED="\033[31m"
RESET="\033[0m"

# Add Git configuration
sudo git config --global user.email "you@example.com"
sudo git config --global user.name "Your Name"

# create user name and root for gitlab
GITLAB_PASS=$(sudo kubectl get secret gitlab-gitlab-initial-root-password -n gitlab -o jsonpath="{.data.password}" | base64 --decode)
sudo echo "machine gitlab.k3d.gitlab.com
login root
password ${GITLAB_PASS}" > ~/.netrc
sudo rm -f /root/.netrc
sudo mv ~/.netrc /root/
sudo chmod 600 /root/.netrc

# clone GitLab repo
sudo git clone http://gitlab.k3d.gitlab.com/root/dvergobb.git git_repo

# Debug output
ls -la git_repo

# clone GitHub repo
sudo git clone https://github.com/damien-vergobbi/dvergobb-iot.git git_dvergobb

# copy from git_dvergobb and git_repo
sudo mv git_dvergobb/* git_repo/

# del repo from github
sudo rm -rf git_dvergobb/

cd git_repo
sudo git add *
sudo git commit -m "update"
sudo git push

# Debug output
git status

cd ..

sudo kubectl apply -f ./conf/deploy.yaml

# Write command
echo -n "\n${BOLD}Command to start wil-app:${RESET}\n"
echo -n "\tsudo kubectl port-forward svc/svc-wil -n dev 8888:8080\n"
echo -n "Then visit ${ITALIC}http://localhost:8888${RESET}\n"
