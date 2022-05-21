#!/bin/bash

echo "init.sh"

##install yq - for yaml files manipulation
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys CC86BB64
sudo add-apt-repository ppa:rmescandon/yq -y
sudo apt update
sudo apt install yq -y

cd $HOME/easy-free5gc/linux

./netplan.sh

./free5gc-dependencies.sh

./kubernetes.sh