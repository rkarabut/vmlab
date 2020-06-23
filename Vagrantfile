VM_SYNCED_FOLDER = ENV["VM_SYNCED_FOLDER"] || "d:/vm/shared"
VM_RAM = ENV["VM_RAM"] || 4096
VM_NAME = ENV["VM_NAME"] || "ri-base-lab"

SHELL_ENV = {
    "VM_USERNAME": "ri",
    "VM_PASSWORD": "ri",
}

Vagrant.configure("2") do |config|
  config.vagrant.plugins = ["vagrant-vbguest", "vagrant-disksize"]
  
  config.disksize.size = '40GB'
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

  config.vm.provision "upload-scripts", type: "file", source: "./scripts/user", destination: "/tmp/scripts"  

  config.vm.provision "bootstrap", type: "shell", after: "upload-scripts", path: "./scripts/bootstrap.sh", env: SHELL_ENV

  config.vm.provision "run-scripts", type: "shell", after: "bootstrap", path: "./scripts/run_scripts.sh", env: SHELL_ENV

  config.vbguest.auto_update = true
  
  config.vm.synced_folder VM_SYNCED_FOLDER, "/shared"

end
