#!/bin/bash

set -x
cd ~ || exit 1
rm -rf ~/pdfgpt
git clone "https://ayoubelmhamdi:$1@github.com/ayoubelmhamdi/pdfgpt.git"
cd ~/pdfgpt || exit 1

git config --global user.name "{your_username}"
git config --global user.email "{your_email_id}"
git config --global user.password "{your_password}"

sudo apt -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install neovim
sudo ln -s "$(which nvim)" /usr/bin/v
sudo apt -y install docker-ce docker-ce-cli containerd.io

# curl --proto '=https' --tlsv1.2 -sSf  https://raw.githubusercontent.com/ayoubelmhamdi/pdfgpt/master/console.sh | bash
