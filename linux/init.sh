#!/bin/bash

echo "init.sh"

cd $HOME/easy-free5gc/linux

./common.sh

./netplan.sh

./free5gc-dependencies.sh

./kubernetes.sh