#!/bin/bash

echo "worker/init.sh"

./netplan.sh

./routing.sh

./free5gc-dependencies.sh

#append node internal ip to kubelet args so worker gets proper address in k8s
#added because address of eth1 was getting assigned
sudo sed -i '${s/$/ --node-ip 192.168.10.3/}' /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
sudo systemctl daemon-reload
sudo systemctl restart kubelet
