#!/bin/sh

minikube delete
killall -TERM kubectl minikube VBoxHeadless

minikube start --vm-driver=docker --extra-config=apiserver.service-node-port-range=1-65535

eval $(minikube docker-env)

# see what changes would be made, returns nonzero returncode if different
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl diff -f - -n kube-system

# actually apply the changes, returns nonzero returncode on errors only
kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl apply -f - -n kube-system

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/metallb.yaml
# On first install only
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

docker build -t sehattor/nginx ./srcs/nginx/
docker build -t sehattor/mysql ./srcs/mysql/
docker build -t sehattor/wordpress ./srcs/wordpress/
docker build -t sehattor/phpmyadmin ./srcs/phpmyadmin/
docker build -t sehattor/influxdb ./srcs/influxdb/

kubectl apply -f ./srcs/metallb/metallb.yaml 
kubectl apply -f ./srcs/nginx/nginx.yaml
kubectl apply -f ./srcs/mysql/mysql.yaml
kubectl apply -f ./srcs/wordpress/wordpress.yaml
kubectl apply -f ./srcs/phpmyadmin/phpmyadmin.yaml
kubectl apply -f ./srcs/influxdb/influxdb.yaml 