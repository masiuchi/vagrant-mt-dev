# -*- mode: ruby -*-
# vi: set ft=ruby :

def configure_default
  Vagrant.configure("2") do |config|
    config.vm.box = "masahiroiuchi/mt-dev"
    config.vm.hostname = "mt-dev.test"
    config.vm.network "private_network", type: "dhcp"
    if File.exists?("provision.sh")
      config.vm.provision "shell", path: "provision.sh"
    end

    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.ip_resolver = proc do |vm, resolving_vm|
      if hostname = (vm.ssh_info && vm.ssh_info[:host])
        `vagrant ssh -c "/sbin/ifconfig eth1" | grep "inet addr" | tail -n 1 | egrep -o "[0-9\.]+" | head -n 1 2>&1`.split("\n").first[/(\d+\.\d+\.\d+\.\d+)/, 1]
      end
    end
  end
end

def configure_build
  Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/precise64"
    config.vm.provision "shell", path: "provision.sh"
    config.vm.provider 'virtualbox' do |vb|
      vb.customize ["modifyvm", :id, "--cpus", "2"]
      vb.customize ["modifyvm", :id, "--memory", "4096"]
    end
  end
end

def configure_package
  Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/precise64"
    config.vm.provider 'virtualbox' do |vb|
      vb.customize ["modifyvm", :id, "--cpus", "1"]
      vb.customize ["modifyvm", :id, "--memory", "512"]
    end
  end
end

def configure_development
  Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/precise64"
    config.vm.hostname = "mt-dev.test"
    config.vm.provision "shell", path: "provision.sh"
    config.vm.network "private_network", type: "dhcp"

    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.ip_resolver = proc do |vm, resolving_vm|
      if hostname = (vm.ssh_info && vm.ssh_info[:host])
        `vagrant ssh -c "/sbin/ifconfig eth1" | grep "inet addr" | tail -n 1 | egrep -o "[0-9\.]+" | head -n 1 2>&1`.split("\n").first[/(\d+\.\d+\.\d+\.\d+)/, 1]
      end
    end
  end
end

send "configure_" + (ENV['MT_DEV'] || 'default')

