docker build -t rosslutsch/multi-client:latest -t rosslutsch/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rosslutsch/multi-server:latest -t rosslutsch/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rosslutsch/multi-worker:latest -t rosslutsch/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push rosslutsch/multi-client:latest
docker push rosslutsch/multi-server:latest
docker push rosslutsch/multi-worker:latest

docker push rosslutsch/multi-client:$SHA
docker push rosslutsch/multi-server:$SHA
docker push rosslutsch/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=rosslutsch/multi-server:$SHA
kubectl set image deployments/client-deployment client=rosslutsch/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=rosslutsch/multi-worker:$SHA
