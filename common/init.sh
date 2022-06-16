#!/bin/bash

echo "common/init.sh"

cd $HOME/easy-free5gc/common

sudo ./addSudoers.sh

./common.sh

./kubernetes.sh

touch $HOME/done