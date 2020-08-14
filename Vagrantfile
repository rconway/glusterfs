# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/bionic64"

  config.vm.base_mac = nil

  # config.vm.network "public_network"

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    vb.cpus = "2"
    vb.linked_clone = true
  end

  config.vm.define "gfs01" do |gfs|
    gfs.vm.hostname = "gfs01"
    gfs.vm.network "private_network", ip: "192.168.100.11"
  end

  config.vm.define "gfs02" do |gfs|
    gfs.vm.hostname = "gfs02"
    gfs.vm.network "private_network", ip: "192.168.100.12"
  end

  config.vm.define "gfsclient" do |gfs|
    gfs.vm.hostname = "gfsclient"
    gfs.vm.network "private_network", ip: "192.168.100.13"
  end

  config.vm.provision "shell", inline: <<-EOT
    grep gfs01 /etc/hosts >/dev/null || echo "192.168.100.11  gfs01" >> /etc/hosts
    grep gfs02 /etc/hosts >/dev/null || echo "192.168.100.12  gfs02" >> /etc/hosts
    grep gfsclient /etc/hosts >/dev/null || echo "192.168.100.13  gfsclient" >> /etc/hosts
  EOT

end
