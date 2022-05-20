#!/bin/bash

NAME="free5gc-project"
SUBNET_NAME="$NAME-kubernetes"

echo "Removing controller and worker..."
gcloud -q compute instances delete \
  controller-0 \
  worker-0  \
  --zone $(gcloud config get-value compute/zone)

echo "Removing static address..."
gcloud -q compute addresses delete $NAME \
  --region $(gcloud config get-value compute/region)

echo "Removing firewall rules..."
gcloud -q compute firewall-rules delete \
  $NAME-allow-internal \
  $NAME-allow-external

echo "Removing VPC subnet..."
gcloud -q compute networks subnets delete $SUBNET_NAME

echo "Removing VPC network..."
gcloud -q compute networks delete $NAME

