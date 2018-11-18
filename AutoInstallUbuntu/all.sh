#!/bin/sh
apt update
apt -y upgrade
apt -y install git

echo "=======================================Install Basic Package================================"
add-apt-repository -y ppa:jonathonf/vim
apt install -y tree htop vim xarchiver

echo "=======================================Install Docker======================================="
./docker.sh

echo "=======================================Install Visual Studio Code==========================="
./vscode.sh

echo "=======================================Install Node========================================="
./node.sh

echo "=======================================Install Golang======================================="
./golang.sh

echo "=======================================Install Sublime Text================================="
./sublime.sh

echo "=======================================Install ZSH=========================================="
./zsh.sh

echo "=======================================Install Ibus Unikey=================================="
./ibus-unikey.sh