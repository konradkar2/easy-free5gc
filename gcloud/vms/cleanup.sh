#!/bin/bash

echo "Removing controller and worker..."
gcloud -q compute instances delete \
  controller-0 \
  worker-0  \
  --zone $(gcloud config get-value compute/zone)