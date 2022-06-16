#!/bin/bash

setup_n6network(){
    yq e -i '.global.n6network.masterIf|="eth1"' values.yaml
    yq e -i '.global.n6network.subnetIP|="10.73.4.0"' values.yaml
    yq e -i '.global.n6network.cidr|=24' values.yaml
    yq e -i '.global.n6network.gatewayIP|="10.73.4.1"' values.yaml
    yq e -i '.global.n6network.excludeIP|="10.73.4.254"' values.yaml
}

echo "controller/free5gc-setup.sh"

cd $HOME/towards5gs-helm/charts/free5gc
setup_n6network


cd charts/free5gc-upf
setup_n6network

yq e -i '.upf.n6if.ipAddress|="10.73.4.222"' values.yaml


cd $HOME/towards5gs-helm/charts/

helm -n free5gc install 3.0.6 ./free5gc/

