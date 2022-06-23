#!/bin/bash

echo "utils/dashboard/getDashboardToken.sh"

kubectl -n kubernetes-dashboard create token admin-user
