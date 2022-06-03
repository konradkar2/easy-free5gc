#!/bin/bash

NAME="free5gc-project"

NET_INTERNAL="$NAME-kubernetes-internal"
NET_DN="$NAME-kubernetes-dn"

SUBNET_INTERNAL="$NET_INTERNAL-subnet"
SUBNET_DN="$NET_DN-subnet"

echo "Creating VPC network..."
gcloud compute networks create $NET_INTERNAL --subnet-mode custom
gcloud compute networks create $NET_DN --subnet-mode custom

echo -e "\nCreating subnet..."
gcloud compute networks subnets create $SUBNET_INTERNAL \
  --network $NET_INTERNAL \
  --range 192.168.10.0/24

gcloud compute networks subnets create $SUBNET_DN \
  --network $NET_DN \
  --range 192.168.11.0/24

echo -e "\nCreating internal traffic firewall rule..."
gcloud compute firewall-rules create $NET_INTERNAL-allow-internal \
  --allow all \
  --network $NET_INTERNAL \
  --source-ranges 192.168.10.0/24

gcloud compute firewall-rules create $NET_DN-allow-internal \
  --allow all \
  --network $NET_DN \
  --source-ranges 192.168.11.0/24

echo -e "\nCreating external traffic firewall rule..."
gcloud compute firewall-rules create $NET_INTERNAL-allow-external \
  --allow all \
  --network $NET_INTERNAL \
  --source-ranges 0.0.0.0/0

gcloud compute firewall-rules create $NET_DN-allow-external \
  --allow all \
  --network $NET_DN \
  --source-ranges 0.0.0.0/0

echo -e "\nfirewall rules:"
gcloud compute firewall-rules list --filter="network:$NAME*"

echo -e "\nCreating static IP address:"
gcloud compute addresses create $NAME \
  --region $(gcloud config get-value compute/region)


./vms/init.sh


echo -e "\nAll done!"
echo -e "To connect via SSH to VM execute:\n
  gcloud compute ssh controller-0
  gcloud compute ssh worker-0"