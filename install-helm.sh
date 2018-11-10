#!/bin/bash

run() {
   command "$@" || exit 1
}

# install helm
cd ~
run wget https://storage.googleapis.com/kubernetes-helm/helm-v2.11.0-linux-amd64.tar.gz
run tar xfvz helm-v2.11.0-linux-amd64.tar.gz
run cp linux-amd64/helm /usr/bin/
run helm init
#run kubectl create serviceaccount --namespace kube-system tiller
#run kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
#run kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
run helm list
run helm repo update

