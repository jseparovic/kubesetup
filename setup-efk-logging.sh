#!/bin/bash

run() {
   command "$@" || exit 1
}

# create local storage
run kubectl apply -f https://raw.githubusercontent.com/jseparovic/kubesetup/master/specs/local-storage-class.yaml
run kubectl patch storageclass local-storage -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'

# https://akomljen.com/get-kubernetes-logs-with-efk-stack-in-5-minutes/

# clean up existing logging namespace and persistent volumes
kubectl delete namespace logging
kubectl delete pv es-data-es-data-efk-cluster-default-0
kubectl delete pv es-data-es-master-efk-cluster-default-0

# create logging namespace
run kubectl create namespace logging

# Create persistent volume
run kubectl apply -f https://raw.githubusercontent.com/jseparovic/kubesetup/master/specs/es-persistent-volumes.yaml

# Add helm repo
run helm repo add akomljen-charts https://raw.githubusercontent.com/komljen/helm-charts/master/charts/

# Add es pods
helm del --purge es-operator
run helm install --name es-operator --set rbac.create=true --namespace logging akomljen-charts/elasticsearch-operator
helm del --purge efk
run helm install --name efk --namespace logging akomljen-charts/efk

