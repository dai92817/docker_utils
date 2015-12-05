#!/bin/bash

read -p "Do you need uninstall docker, [yes/no]" Choose
if [[ $Choose == 'yes' ]]; then
	echo "begin uninstall docker..."
	sudo apt-get autoremove --purge docker-engine
	echo "Are you want to delete all images, containers, and volumes. [yes/no]" is_delete
	if [[ $is_delete == 'yes' ]]; then
		sudo rm -rf /var/lib/docker
    else
        echo ""
    fi
else
    echo ""
fi

# Add the new gpg key
apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

# # Add the Docker repository to your apt sources list.
sudo sh -c "echo deb https://apt.dockerproject.org/repo ubuntu-trusty main > /etc/apt/sources.list.d/docker.list"

sudo apt-get update
# Purge the old repo if it exists.
echo "Aalivable version of Docker:"
sudo apt-get purge lxc-docker*
sudo apt-cache policy docker-engine

read -p "Choose the version you want to install: " docker_version

sudo apt-get install -y docker-engine=$docker_version

if [[ $? == '0' ]]; then
	echo "install docker $docker_version success"
else
	echo "install docker $docker_version failed"
fi
