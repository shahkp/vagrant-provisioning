#!/bin/bash

# Initialize Kubernetes
echo "[TASK 1] Initialize Kubernetes Cluster"
kubeadm init --apiserver-advertise-address=192.168.1.110 --pod-network-cidr=172.16.182.0/24 >> /root/kubeinit.log 2>/dev/null

# Copy Kube admin config
echo "[TASK 2] Copy kube admin config to Vagrant user .kube directory"
mkdir /home/kaushal/.kube
cp /etc/kubernetes/admin.conf /home/kaushal/.kube/config
chown -R kaushal:kaushal /home/kaushal/.kube

# Deploy Calico network
echo "[TASK 3] Deploy Calico network"
su - kaushal -c "kubectl create -f https://docs.projectcalico.org/v3.11/manifests/calico.yaml"

# Generate Cluster join command
echo "[TASK 4] Generate and save cluster join command to /joincluster.sh"
kubeadm token create --print-join-command > /joincluster.sh
