#!/bin/bash

echo "controller/kubernetes.sh"

echo "Installing helm..."
cd $HOME/Download
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh

echo "Starting kubeadm cluster..."
sudo kubeadm init --pod-network-cidr=10.244.0.0/16 --upload-certs

#copy kubeadm config so it can be used by kubectl
mkdir -p $HOME/.kube
sudo cp -f /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config


echo "Applying kube-flannel.yml..."
kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml

cd $HOME
echo -e "\nFetching multus-cni..."
git clone https://github.com/k8snetworkplumbingwg/multus-cni

echo -e "\nApplying multus-daemonset-yml..."
kubectl apply -f $HOME/multus-cni/deployments/multus-daemonset.yml

echo "Creating persistent volume..."
kubectl create ns free5gc
kubectl apply -f $HOME/easy-free5gc/controler/volume.yml

