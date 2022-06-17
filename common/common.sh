#!/bin/bash

echo "common/common.sh"

mkdir $HOME/Download
mkdir /var/free5gc/kubedata

##install yq - for yaml files manipulation
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys CC86BB64
sudo add-apt-repository ppa:rmescandon/yq -y
sudo apt update
sudo apt install yq -y

##install build-essential
sudo apt install build-essential -y

#to check connectivity
sudo apt install traceroute -y
