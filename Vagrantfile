# -*- mode: ruby -*-
# vi: set ft=ruby :

if ENV['MT_DEV']
  require "./Vagrantfile_#{ENV['MT_DEV']}.rb"
  exit
end

Vagrant.configure("2") do |config|
  config.vm.box = "masahiroiuchi/mt-dev"
  config.vm.hostname = "mt-dev.test"
  config.vm.network "private_network", type: "dhcp"

  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.ip_resolver = proc do |vm, resolving_vm|
    if hostname = (vm.ssh_info && vm.ssh_info[:host])
      `vagrant ssh -c "/sbin/ifconfig eth1" | grep "inet addr" | tail -n 1 | egrep -o "[0-9\.]+" | head -n 1 2>&1`.split("\n").first[/(\d+\.\d+\.\d+\.\d+)/, 1]
    end
  end
end

