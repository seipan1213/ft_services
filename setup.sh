#!/bin/sh

minikube delete

killall -TERM kubectl minikube VBoxHeadless

minikube start --vm-driver=docker --extra-config=apiserver.service-node-port-range=1-65535

eval $(minikube docker-env)

kubectl get configmap kube-proxy -n kube-system -o yaml | \
sed -e "s/strictARP: false/strictARP: true/" | \
kubectl diff -f - -n kube-system

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

docker build -t sehattor/influxdb:v1 ./srcs/influxdb/
docker build -t sehattor/mysql:v1 ./srcs/mysql/
docker build -t sehattor/ftps:v1 ./srcs/ftps/
docker build -t sehattor/nginx:v1 ./srcs/nginx/
docker build -t sehattor/phpmyadmin:v1 ./srcs/phpmyadmin/
docker build -t sehattor/wordpress:v1 ./srcs/wordpress/
docker build -t sehattor/grafana:v1 ./srcs/grafana/

kubectl apply -f ./srcs/metallb/metallb.yaml
kubectl apply -f ./srcs/influxdb/influxdb.yaml
kubectl apply -f ./srcs/mysql/mysql.yaml
kubectl apply -f ./srcs/ftps/ftps.yaml
kubectl apply -f ./srcs/nginx/nginx.yaml
kubectl apply -f ./srcs/phpmyadmin/phpmyadmin.yaml
kubectl apply -f ./srcs/wordpress/wordpress.yaml
kubectl apply -f ./srcs/grafana/grafana.yaml