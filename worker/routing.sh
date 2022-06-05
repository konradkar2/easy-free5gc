#!/bin/bash

echo "worker/routing.sh"

#setup routing for eth1, this is required on GCP for any additional interface
IP_ADDRESS=192.168.11.100
NETMASK=255.255.255.255
CIDR=32
GATEWAY_ADDRESS=192.168.11.1

sudo echo "1 rt1" | sudo tee -a /etc/iproute2/rt_tables
sudo ip route add $GATEWAY_ADDRESS src $IP_ADDRESS dev eth1 table rt1
sudo ip route add default via $GATEWAY_ADDRESS dev eth1 table rt1
sudo ip rule add from $IP_ADDRESS/$CIDR table rt1
sudo ip rule add to $IP_ADDRESS/$CIDR table rt1