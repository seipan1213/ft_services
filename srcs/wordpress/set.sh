minikube delete
killall -TERM kubectl minikube VBoxHeadless

minikube start --vm-driver=docker --extra-config=apiserver.service-node-port-range=1-65535
eval $(minikube docker-env)

kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/metallb.yaml
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"

docker build -t sehattor/mysql ../mysql/
docker build -t sehattor/wordpress .

kubectl apply -f ../metallb/metallb.yaml

kubectl apply -f ../mysql/mysql.yaml
kubectl apply -f wordpress.yaml
