#!/bin/sh

# Install DockerCE

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) edge"
apt update
apt install -y docker-ce

#Allow non-root user can use docker command

sudo usermod -a -G docker $USER

#Start docker daemon automatically

systemctl enable docker

echo 'Done!'

echo 'Install Docker Compose'

curl -L "https://github.com/docker/compose/releases/download/1.23.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

docker-compose --version