Vagrant.configure("2") do |config|
  # Specify the base box to use for the VM
  config.vm.box = "hashicorp/bionic64"
  
  # Forward port 443 from guest VM to host port 4443, accessible from any interface
  config.vm.network "forwarded_port", guest: 443, host: 4443, host_ip: "0.0.0.0"
  
  # Commented out DHCP private network configuration
  #config.vm.network "private_network", type: "dhcp"
  
  # Set up a private network with static IP for predictable addressing
  config.vm.network "private_network", ip: "192.168.56.23"
  
  # Commented out shared folder configuration
  # config.vm.synced_folder "./src", "/vagrant"
  
  # Define the VM name and hostname
  config.vm.define "WordpressServer" do |control|
    control.vm.hostname = "WordpressServer"
  end
  
  # Configure VirtualBox provider settings
  config.vm.provider "virtualbox" do |vb|
    # Allocate 4GB of RAM to the VM
    vb.memory = "4096"
    # Assign 4 CPU cores to the VM
    vb.cpus = 4
  end  
end
