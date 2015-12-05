#!/bin/bash
RED='\E[1;31m'
RES='\E[0m'

sudo docker -v
if [[ $? -eq 0 ]]; then
    echo -e "${RED}Do you want to uninstall docker. [yes/no] ${RES}"
    read yn
    if [ "$yn" == "yes" -o "$yn" == "y" ]; then
	    echo -e "begin uninstall docker..."
	    sudo apt-get autoremove --purge docker-engine
        echo -e "${RED}Are you want to delete all images, containers and volumes. [yee/no] ${RES}"
        read yn
	    if [ "$yn" == "yes" -o "$yn" == "y" ]; then
		    sudo rm -rf /var/lib/docker
        fi
    fi
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

echo -e "${RED}Choose the version you want to install: ${RES}" 
read docker_version

sudo apt-get install -y docker-engine=$docker_version

if [[ $? -eq 0 ]]; then
	echo "install docker $docker_version success"
else
	echo "install docker $docker_version failed"
fi
