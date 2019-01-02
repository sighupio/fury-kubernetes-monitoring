#!/bin/sh
# Utils
sudo apt-get update && \
  sudo apt-get install unzip

## Ansible
#sudo apt-get update && \
  #sudo apt-get install -y software-properties-common && \
  #sudo apt-add-repository --yes --update ppa:ansible/ansible && \
  #sudo apt-get update && \
  #sudo apt-get install -y ansible

## Terraform
#cd /tmp
#if ! type terraform > /dev/null; then
  #wget https://releases.hashicorp.com/terraform/0.11.10/terraform_0.11.10_linux_amd64.zip
  #unzip terraform_0.11.10_linux_amd64.zip
  #sudo mv terraform /usr/local/bin/
#fi

# Single Node K8S
if ! type microk8s.status > /dev/null; then
  sudo snap install microk8s --classic
  sudo snap alias microk8s.kubectl kubectl
  sudo snap alias microk8s.docker docker
fi

microk8s.status --wait-ready
microk8s.enable dns dashboard ingress storage
microk8s.kubectl config view > /workspace/kubeconfig
sed -i 's/127.0.0.1/192.168.31.31/g' /workspace/kubeconfig
