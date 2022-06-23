#!/bin/bash

echo "utils/dashboard/init.sh"

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.6.0/aio/deploy/recommended.yaml

SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]:-$0}"; )" &> /dev/null && pwd 2> /dev/null; )";

kubectl apply -f $SCRIPT_DIR/serviceAccount.yml
kubectl apply -f $SCRIPT_DIR/clusterRoleBinding.yml

$SCRIPT_DIR/getDashboardToken.sh

echo "Done! Launch dashboard proxy and apply the token."
echo "http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/"