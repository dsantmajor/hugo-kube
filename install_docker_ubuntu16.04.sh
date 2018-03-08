#!/bin/bash

echo "SET UP THE REPOSITORY"
echo "Update the apt package index:"

sudo apt-get update -y

echo "Install packages to allow apt to use a repository over HTTPS:"

sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

echo "Add Docker’s official GPG key:"

$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
echo "Verify that you now have the key with the fingerprint 9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88, by searching for the last 8 characters of the fingerprint.
"
sudo apt-key fingerprint 0EBFCD88

# pub   4096R/0EBFCD88 2017-02-22
#       Key fingerprint = 9DC8 5822 9FC7 DD38 854A  E2D8 8D81 803C 0EBF CD88
# uid                  Docker Release (CE deb) <docker@docker.com>
# sub   4096R/F273FCD8 2017-02-22

echo "Use the following command to set up the stable repository. You always need the stable repository, even if you want to install builds from the edge or test repositories as well. To add the edge or test repository, add the word edge or test (or both) after the word stable in the commands below.

Note: The lsb_release -cs sub-command below returns the name of your Ubuntu distribution, such as xenial. Sometimes, in a distribution like Linux Mint, you might need to change $(lsb_release -cs) to your parent Ubuntu distribution. For example, if you are using Linux Mint Rafaela, you could use trusty.

x86_64 / amd64
armhf
IBM Power (ppc64le)
IBM Z (s390x)"

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

echo "Note: Starting with Docker 17.06, stable releases are also pushed to the edge and test repositories."

# Learn about stable and edge channels.

echo "INSTALL DOCKER CE
Update the apt package index."

sudo apt-get update -y

echo "Install the latest version of Docker CE, or go to the next step to install a specific version. Any existing installation of Docker is replaced.
"
sudo apt-get install docker-ce

echo "latest version of docker installed"
echo "======================================================"
echo "||        docker VERSION                     ||"
echo "======================================================="
sudo docker version

echo "======================================================"
echo "||       Installing docker-compose                  ||"
echo "======================================================="
sudo curl -L https://github.com/docker/compose/releases/download/1.1 9.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose


echo "======================================================"
echo "||        docker-compose VERSION                     ||"
echo "======================================================="
docker-compose --version
