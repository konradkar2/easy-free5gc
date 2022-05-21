#!/bin/bash

echo "netplan.sh"

sudo cp /etc/netplan/50-cloud-init.yaml /etc/netplan/50-cloud-init.yaml.backup

#replace every interface name with single, unique string
sudo yq e -i '.network.ethernets |= with_entries(.value.set-name = "TO_BE_REPLACED")' /etc/netplan/50-cloud-init.yaml

#replace all "TO_BE_REPLACED" strings with "eth0,eth1,eth2.." values
sudo awk -i inplace -v word=TO_BE_REPLACED '{gsub("\\<" word "\\>", word (++count)-1); print}' /etc/netplan/50-cloud-init.yaml

sudo netplan apply /etc/netplan/50-cloud-init.yaml