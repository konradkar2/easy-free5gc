#!/bin/bash

NAME="free5gc-project"
STATIC_ADDRESS=$NAME

NET_INTERNAL="$NAME-kubernetes-internal"
NET_DN="$NAME-kubernetes-dn"

SUBNET_INTERNAL="$NET_INTERNAL-subnet"
SUBNET_DN="$NET_DN-subnet"


cd vms

echo -e "\nCreating kubernetes control-plane VM"
gcloud compute instances create controller-0 \
   --boot-disk-size 100GB \
   --can-ip-forward \
   --image-family ubuntu-2004-lts \
   --image-project ubuntu-os-cloud \
   --machine-type e2-standard-2 \
   --metadata-from-file=startup-script=vm-startup-script.sh \
   --network-interface network=$NET_INTERNAL,subnet=$SUBNET_INTERNAL,private-network-ip=192.168.10.2,address=$STATIC_ADDRESS \
   --scopes compute-rw,storage-ro,service-management,service-control,logging-write,monitoring \
   --tags $NAME,controller

echo -e "\nCreating kubernetes worker VM"
gcloud compute instances create worker-0 \
    --boot-disk-size 200GB \
    --can-ip-forward \
    --image-family ubuntu-2004-lts \
    --image-project ubuntu-os-cloud \
    --machine-type e2-standard-4 \
    --metadata-from-file=startup-script=vm-startup-script.sh \
    --network-interface network=$NET_INTERNAL,subnet=$SUBNET_INTERNAL,private-network-ip=192.168.10.3 \
    --network-interface network=$NET_DN,subnet=$SUBNET_DN,private-network-ip=192.168.11.100 \
    --scopes compute-rw,storage-ro,service-management,service-control,logging-write,monitoring \
    --tags $NAME,worker