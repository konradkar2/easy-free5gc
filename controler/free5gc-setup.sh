#!/bin/bash

echo "controller/free5gc-setup.sh"

cd $HOME/towards5gs-helm/charts/free5gc

yq e -i '.global.n6network.masterIf|="eth0"' values.yaml
yq e -i '.global.n6network.subnetIP|="10.0.0.0"' values.yaml
yq e -i '.global.n6network.cidr|=8' values.yaml
yq e -i '.global.n6network.gatewayIP|="10.0.0.12"' values.yaml
yq e -i '.global.n6network.excludeIP|="10.0.0.12"' values.yaml
