#!/bin/bash

echo "worker/init.sh"

./netplan.sh

./routing.sh

./free5gc-dependencies.sh