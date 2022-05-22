#!/bin/bash

echo "netplan.sh"

##modify netplan to suit towards5gs and apply it

NETPLAN_CONFIG=/etc/netplan/50-cloud-init.yaml

sudo cp $NETPLAN_CONFIG $NETPLAN_CONFIG.backup

#replace every interface name (and set-name field) with signle string
sudo yq e -i '.network.ethernets |= with_entries(.key = "TO_BE_REPLACED_KEY")' $NETPLAN_CONFIG
sudo yq e -i '.network.ethernets |= with_entries(.value.set-name = "TO_BE_REPLACED_VALUE_SET_NAME")' $NETPLAN_CONFIG

#replace all "TO_BE_REPLACED..." strings with "eth0,eth1,eth2.." values
sudo awk -i inplace 'sub("TO_BE_REPLACED_KEY","eth"cnt+0, $0){cnt++}1' $NETPLAN_CONFIG
sudo awk -i inplace 'sub("TO_BE_REPLACED_VALUE_SET_NAME","eth"cnt+0, $0){cnt++}1' $NETPLAN_CONFIG

sudo netplan apply /etc/netplan/50-cloud-init.yaml

sleep 3