#!/bin/bash

NAME="free5gc-project"

NET_INTERNAL="$NAME-kubernetes-internal"
NET_DN="$NAME-kubernetes-dn"

SUBNET_INTERNAL="$NET_INTERNAL-subnet"
SUBNET_DN="$NET_DN-subnet"


./vms/cleanup.sh

echo "Removing static address..."
gcloud -q compute addresses delete $NAME \
  --region $(gcloud config get-value compute/region)

echo "Removing firewall rules..."
gcloud -q compute firewall-rules delete \
  $NET_INTERNAL-allow-internal \
  $NET_INTERNAL-allow-external \
  $NET_DN-allow-internal \
  $NET_DN-allow-external \

echo "Removing VPC subnet..."
gcloud -q compute networks subnets delete \
  $SUBNET_INTERNAL \
  $SUBNET_DN

echo "Removing VPC network..."
gcloud -q compute networks delete \
  $NET_INTERNAL \
  $NET_DN \

