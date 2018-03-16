#!/usr/bin/env bash

# get the `kompose` tool to create Kubernetes resources
# from a docker-compose file
curl -L https://github.com/kubernetes/kompose/releases/download/v1.10.0/kompose-linux-amd64 -o kompose

chmod +x kompose
sudo mv ./kompose /usr/local/bin/kompose

# point kompose at a docker-compose.yml file
cd $HOME/github/pg_docker/compose

kompose --deployment .

mv $HOME/github/pg_docker/compose/*.yaml $HOME/github/pg_docker/k8s

cd $HOME/github/pg_docker/k8s

# install minikube for local kubernetes experimentation
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
    && chmod +x minikube \
    && sudo mv minikube /usr/local/bin/

# setup minikube
export MINIKUBE_WANTUPDATENOTIFICATION=false
export MINIKUBE_WANTREPORTERRORPROMPT=false
export MINIKUBE_HOME=$HOME
export CHANGE_MINIKUBE_NONE_USER=true
mkdir $HOME/.kube || true
touch $HOME/.kube/config

# NOTE: I'm doing this demo on Linux, so I can get away with `--vm-driver=None`
# however, the virtualbox driver is also pretty good
export KUBECONFIG=$HOME/.kube/config
sudo -E minikube start --vm-driver=none

# this for loop waits until kubectl can access the api server that Minikube has created
for i in {1..150}; do # timeout for 5 minutes
   ./kubectl get po &> /dev/null
   if [ $? -ne 1 ]; then
      break
  fi
  sleep 2
done

# get kubectl for cli management of kubernetes / minikube
curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && sudo mv ./kubectl /usr/local/bin/kubectl

# ok we should have kubectl now and a minikube kubectl context
kubectl config use-context minikube

# dashboard lives here
minikube dashboard

# have to set the image pulling policy for our app deployment
# since it is a locally built image (you also might have to build
# the image if it hasn't been built already)
spec.template.spec.containers[].args.imagePullPolicy: Never

# deploy!!!
kubectl apply -f .

# teardown everything
minikube delete

rm -rf ~/.minikube
