#!/bin/bash

echo "controller/init.sh"

./kubernetes.sh

echo "Installing helm..."
cd $HOME/Download
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

echo "cloning towards5gs-helm..."
cd $HOME
git clone https://github.com/Orange-OpenSource/towards5gs-helm.git

$HOME/easy-free5gc/controler/free5gc-setup.sh