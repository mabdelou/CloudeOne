Vagrant.configure("2") do |config|
  config.vm.box = "hashicorp/bionic64"
  config.vm.network "forwarded_port", guest: 443, host: 4443, host_ip: "0.0.0.0"
  #config.vm.network "private_network", type: "dhcp"
  config.vm.network "private_network", ip: "192.168.56.23"
  config.vm.synced_folder "./src", "/vagrant"
  config.vm.define "WordpressServer" do |control|
    control.vm.hostname = "WordpressServer"
  end
  
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "4096"
    vb.cpus = 4
  end  
end
