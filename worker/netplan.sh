#!/bin/bash

echo "netplan.sh"

##modify netplan to suit towards5gs and apply it

NETPLAN_CONFIG=/etc/netplan/50-cloud-init.yaml

sudo cp $NETPLAN_CONFIG $NETPLAN_CONFIG.backup

#rename first interface to eth0
sudo yq e -i '.network.ethernets |= with_entries(.key = "eth0")' $NETPLAN_CONFIG
sudo yq e -i '.network.ethernets |= with_entries(.value.set-name = "eth0")' $NETPLAN_CONFIG

#rename ens5 interface to eth1 (it does not exist in netplan so here we add it)
MAC_ADDRESS=$(ip -brief link show | grep ens5 | awk '{print $3;}')

sudo yq e -i '.network.ethernets.eth1.dhcp4 |= true' /etc/netplan/50-cloud-init.yaml
sudo yq e -i ".network.ethernets.eth1.match.macaddress |= \"$MAC_ADDRESS\"" /etc/netplan/50-cloud-init.yaml
sudo yq e -i '.network.ethernets.eth1.set-name|="eth1"' /etc/netplan/50-cloud-init.yaml

sudo netplan apply /etc/netplan/50-cloud-init.yaml
sleep 3


