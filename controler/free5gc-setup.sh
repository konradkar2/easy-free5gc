#!/bin/bash

echo "controller/free5gc-setup.sh"

cd $HOME/towards5gs-helm/charts/free5gc

yq e -i '.global.n6network.masterIf|="eth0"' values.yaml
yq e -i '.global.n6network.subnetIP|="192.168.10.0"' values.yaml
yq e -i '.global.n6network.cidr|=24' values.yaml
yq e -i '.global.n6network.gatewayIP|="192.168.10.12"' values.yaml
yq e -i '.global.n6network.excludeIP|="192.168.10.12"' values.yaml

cd charts/free5gc-upf
yq e -i '.global.n6network.masterIf|="eth0"' values.yaml
yq e -i '.global.n6network.subnetIP|="192.168.10.0"' values.yaml
yq e -i '.global.n6network.cidr|=24' values.yaml
yq e -i '.global.n6network.gatewayIP|="192.168.10.12"' values.yaml
yq e -i '.global.n6network.excludeIP|="192.168.10.12"' values.yaml

yq e -i '.upf.n6if.ipAddress|="192.168.10.100"' values.yaml


cd $HOME/towards5gs-helm/charts/

helm -n free5gc install 3.0.6 ./free5gc/
helm -n free5gc install 3.0.6.ran ./ueransim/
