#!/bin/bash
set -e

##########################################################
# Install script for Docker-CE on ElementaryOS 0.4.1 Loki
# Had to update the repository to point to xenial instead
# of using 'lsb_release -cs' because there's no loki
# repository at download.docker.com.
##########################################################

sudo apt-get update;

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common;

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -;

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable";

sudo apt-get update;

sudo apt-get install docker-ce;

sudo systemctl enable docker;

echo 'All done!'
