#!/bin/sh


echo "=======================================Install Zsh======================================="

apt update

apt-get install -y zsh

zsh --version

chsh -s $(which zsh)

echo $SHELL

$SHELL --version

echo "=======================================Install Oh My Zsh======================================="

sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"