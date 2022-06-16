#!/bin/bash

echo "worker/init.sh"

if [ "$#" -ne 2 ]
    then
        echo "Please provide original names of eth0, eth1 interfaces, as they are about to be renamed."
        exit
fi

./netplan.sh "$1" "$2"

./routing.sh

./free5gc-dependencies.sh

#append node internal ip to kubelet args so worker gets proper address in k8s
#added because address of eth1 was getting assigned

eth0_ip=$(ip --brief address show | grep eth0 | awk '{ print $3}' | cut -d/ -f1)
echo "$eth0_ip"

sudo sed -i '${s/$/ --node-ip '"$eth0_ip"'/}' /etc/systemd/system/kubelet.service.d/10-kubeadm.conf

sudo systemctl daemon-reload
sudo systemctl restart kubelet