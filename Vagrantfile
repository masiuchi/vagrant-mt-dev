# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/precise64"
  config.vm.provision "shell", path: "provision.sh"

  config.vm.hostname = "mt-dev.test"
  config.vm.network "private_network", ip: "192.168.33.183"

  config.vm.synced_folder ".", "/vagrant", mount_options: ['dmode=777','fmode=777']

  config.vm.provider 'virtualbox' do |vb|
    vb.customize ["modifyvm", :id, "--cpus", "2"]
    vb.customize ["modifyvm", :id, "--memory", "4096"]
  end

  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
end

