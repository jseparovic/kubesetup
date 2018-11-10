#!/bin/bash -x

# create local storage
kubectl apply -f https://raw.githubusercontent.com/jseparovic/kubesetup/master/specs/local-storage-class.yaml
kubectl patch storageclass local-storage -p '{"metadata": {"annotations":{"storageclass.kubernetes.io/is-default-class":"true"}}}'

# https://akomljen.com/get-kubernetes-logs-with-efk-stack-in-5-minutes/

# clean up existing logging namespace
kubectl delete namespace logging

# create logging namespace
kubectl create namespace logging

# Create persistent volume
kubectl apply -f https://raw.githubusercontent.com/jseparovic/kubesetup/master/specs/es-persistent-volume.yaml

# Add helm repo
helm repo add akomljen-charts https://raw.githubusercontent.com/komljen/helm-charts/master/charts/

# Add es pods
helm del --purge es-operator
helm install --name es-operator --set rbac.create=true --namespace logging akomljen-charts/elasticsearch-operator
helm del --purge efk
helm install --name efk --namespace logging akomljen-charts/efk

