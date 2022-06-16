#!/bin/bash

echo "worker/init.sh"

./netplan.sh

./routing.sh

./free5gc-dependencies.sh

#append node internal ip to kubelet args so worker gets proper address in k8s
#added because address of eth1 was getting assigned

eth0_ip=$(ip --brief address show | grep eth0 | awk '{ print $3}' | cut -d/ >
echo $eth0_ip

sudo sed -i '${s/$/ --node-ip '"$eth0_ip"'/}' /etc/systemd/system/kubelet.service.d/10-kubeadm.conf

sudo systemctl daemon-reload
sudo systemctl restart kubelet
