#!/bin/bash -x

gradle() {
   command gradle "$@" || exit 1
}

# install helm
cd ~
wget https://storage.googleapis.com/kubernetes-helm/helm-v2.11.0-linux-amd64.tar.gz  || exit 1
tar xfvz helm-v2.11.0-linux-amd64.tar.gz  || exit 1
cp linux-amd64/helm /usr/bin/  || exit 1
helm init || exit 1
kubectl create serviceaccount --namespace kube-system tiller  || exit 1
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
helm list
helm repo update

