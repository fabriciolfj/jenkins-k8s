eval $(minikube -p minikube docker-env)
docker image build -t myjenkins ./jenkins