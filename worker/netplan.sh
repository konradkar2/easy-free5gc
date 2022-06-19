#!/bin/bash

echo "netplan.sh"

#this creates a netplan that basically renames interfaces provided by arg1, arg2
#this is done to suit towards-5gs settings

#eth0
ETH0_MACADDR=$(ip -o link | grep ether | awk '{ print $2" : "$17 }' | grep $1 | awk '{ print $3} ')
sudo yq e -i ".network.ethernets.eth0.match.macaddress |= \"$ETH0_MACADDR\"" custom-netplan.yaml

#eth1
ETH1_MACADDR=$(ip -o link | grep ether | awk '{ print $2" : "$17 }' | grep $2 | awk '{ print $3} ')
sudo yq e -i ".network.ethernets.eth1.match.macaddress |= \"$ETH1_MACADDR\"" custom-netplan.yaml

sudo cp custom-netplan.yaml /etc/netplan/custom-netplan.yaml

sudo netplan apply /etc/netplan/custom-netplan.yaml
sleep 3

#for some reason needs to be done twice
sudo netplan apply /etc/netplan/custom-netplan.yaml
sleep 3


