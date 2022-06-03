#!/bin/bash

echo "common/init.sh"

cd $HOME/easy-free5gc/common

./common.sh

./kubernetes.sh

touch $HOME/done