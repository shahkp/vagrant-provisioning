# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_NO_PARALLEL'] = 'yes'
Vagrant.configure(2) do |config|
  config.vm.provision "shell", path: "bootstrap.sh"
  config.vm.define "kube-master" do |kubemaster|
    kubemaster.vm.box = "centos/7"
    kubemaster.vm.hostname = "kube-master.example.com"
    kubemaster.vm.network "private_network", ip: "192.168.1.110"
    kubemaster.vm.provider "virtualbox" do |v|
      v.name = "kube-master"
      v.memory = 2048
      v.cpus = 2
      # Prevent VirtualBox from interfering with host audio stack
      v.customize ["modifyvm", :id, "--audio", "none"]
    end
    kubemaster.vm.provision "shell", path: "bootstrap_kube-master.sh"
  end
  NodeCount = 2
  (1..NodeCount).each do |i|
    config.vm.define "kube-worker#{i}" do |workernode|
      workernode.vm.box = "centos/7"
      workernode.vm.hostname = "kube-worker#{i}.example.com"
      workernode.vm.network "private_network", ip: "192.168.1.11#{i}"
      workernode.vm.provider "virtualbox" do |v|
        v.name = "kube-worker#{i}"
        v.memory = 1024
        v.cpus = 1
        # Prevent VirtualBox from interfering with host audio stack
        v.customize ["modifyvm", :id, "--audio", "none"]
      end
      workernode.vm.provision "shell", path: "bootstrap_kube_worker.sh"
    end
  end
end
