VM_SYNCED_FOLDER = ENV["VM_SYNCED_FOLDER"]
VM_RAM = ENV["VM_RAM"] || 3072
VM_NAME = ENV["VM_NAME"] || "ri-base-lab"

Vagrant.configure("2") do |config|
  config.vagrant.plugins = "vagrant-vbguest"
  
  config.vm.box = "debian/buster64"
  config.vm.hostname = VM_NAME

  config.vm.provider :virtualbox do |v|
    v.name = VM_NAME
    v.memory = VM_RAM
    v.gui = false
    v.customize ["modifyvm", :id, "--nested-hw-virt", "on"]
    v.customize ["modifyvm", :id, "--graphicscontroller", "vmsvga"]
    v.customize ["modifyvm", :id, "--accelerate3d", "on"]
    v.customize ["modifyvm", :id, "--vram", "128"]
    v.customize ["modifyvm", :id, "--clipboard-mode", "bidirectional"] 
    v.customize ["modifyvm", :id, "--draganddrop", "bidirectional"]
  end

  config.vm.provision :shell, path: "scripts/bootstrap.sh"

  config.vbguest.auto_update = true
  
  config.vm.synced_folder VM_SYNCED_FOLDER, "/shared"

end
