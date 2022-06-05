#!/bin/bash

echo "controller/init.sh"

./kubernetes.sh

echo "cloning towards5gs-helm..."
cd $HOME
git clone https://github.com/Orange-OpenSource/towards5gs-helm.git

$HOME/easy-free5gc/controler/free5gc-setup.sh

echo "Generating join token..."
kubeadm token create --print-join-command