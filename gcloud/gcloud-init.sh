#!/bin/bash

NAME="free5gc-project"
SUBNET_NAME="$NAME-kubernetes"

echo "Creating VPC network..."
gcloud compute networks create $NAME --subnet-mode custom

echo -e "\nCreating subnet..."
gcloud compute networks subnets create $SUBNET_NAME \
  --network $NAME \
  --range 10.0.0.0/8

echo -e "\nCreating internal traffic firewall rule..."
gcloud compute firewall-rules create $NAME-allow-internal \
  --allow all \
  --network $NAME \
  --source-ranges 10.0.0.0/8

echo -e "\nCreating external traffic firewall rule..."
gcloud compute firewall-rules create $NAME-allow-external \
  --allow tcp:22,tcp:6443,icmp \
  --network $NAME \
  --source-ranges 0.0.0.0/0

echo -e "\nfirewall rules:"
gcloud compute firewall-rules list --filter="network:$NAME"

echo -e "\nCreating static IP address:"
gcloud compute addresses create $NAME \
  --region $(gcloud config get-value compute/region)

echo -e "\nCreating kubernetes control-plane VM"
gcloud compute instances create controller-0 \
   --boot-disk-size 100GB \
   --can-ip-forward \
   --image-family ubuntu-2004-lts \
   --image-project ubuntu-os-cloud \
   --machine-type e2-standard-2 \
   --private-network-ip 10.240.0.1 \
   --scopes compute-rw,storage-ro,service-management,service-control,logging-write,monitoring \
   --subnet $SUBNET_NAME \
   --tags $NAME,controller

echo -e "\nCreating kubernetes worker VM"
gcloud compute instances create worker-0 \
    --boot-disk-size 200GB \
    --can-ip-forward \
    --image-family ubuntu-2004-lts \
    --image-project ubuntu-os-cloud \
    --machine-type e2-standard-2 \
    --private-network-ip 10.0.0.12 \
    --scopes compute-rw,storage-ro,service-management,service-control,logging-write,monitoring \
    --subnet $SUBNET_NAME \
    --tags $NAME,worker

echo -e "\nAll done!"
echo -e "To connect via SSH to VM execute:\ngcloud compute ssh controller-0\ngcloud compute ssh worker-0"