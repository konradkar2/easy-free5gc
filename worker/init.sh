#!/bin/bash

echo "worker/init.sh"

if [ "$#" -ne 2 ]
    then
        echo "Please provide original names of eth0, eth1 interfaces, as they are about to be renamed."
        exit
fi

./netplan.sh "$1" "$2"

./routing.sh

./free5gc-dependencies.sh

./nodeAddressFix.sh