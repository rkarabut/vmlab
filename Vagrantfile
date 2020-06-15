Vagrant.configure("2") do |config|
  config.vagrant.plugins = "vagrant-vbguest"
  
  config.vm.box = "debian/buster64"
  config.vm.hostname = "ri-android-lab"

  config.vm.provider :virtualbox do |v|
    v.name = "ri-android-lab"
    v.memory = 3072
    v.gui = false
    v.customize ["modifyvm", :id, "--nested-hw-virt", "on"]
    v.customize ["modifyvm", :id, "--graphicscontroller", "vmsvga"]
    v.customize ["modifyvm", :id, "--accelerate3d", "on"]
    v.customize ["modifyvm", :id, "--vram", "128"]
    v.customize ["modifyvm", :id, "--clipboard-mode", "bidirectional"] 
    v.customize ["modifyvm", :id, "--draganddrop", "bidirectional"]
  end

  config.vm.provision :shell, path: "bootstrap.sh"

  config.vbguest.auto_update = true
  
  config.vm.synced_folder "d:\\vm\\shared", "/shared"

  config.trigger.after :up do |t|
    t.run = {inline: "vagrant halt"}
  end
end
