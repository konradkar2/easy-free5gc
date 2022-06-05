#!/bin/bash

echo "worker/init.sh"

sudo apt install traceroute -y #to check connectivity

./netplan.sh

./routing.sh

./free5gc-dependencies.sh