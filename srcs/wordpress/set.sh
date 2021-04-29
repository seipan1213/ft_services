kubectl delete -f wordpress.yaml
kubectl delete -f ../mysql/mysql.yaml
eval $(minikube docker-env)
docker build -t sehattor/mysql ../mysql/
docker build -t sehattor/wordpress .
kubectl apply -f sehattor/mysql
kubectl apply -f sehattor/wordpress .
