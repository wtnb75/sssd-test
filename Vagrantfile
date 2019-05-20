VAGRANTFILE_API_VERSION = "2"

boxes = [
  # hostname network
  ["master", "192.168.3.10"],
  #["slave1", "192.168.3.11"],
  #["slave2", "192.168.3.12"],
  ["client", "192.168.3.20"],
]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "centos/7"
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.auto_detect=true
  end
  if Vagrant.has_plugin?("vagrant-proxyconf")
    config.proxy.http     = "http://proxy.iiji.jp:8080"
    config.proxy.https    = "http://proxy.iiji.jp:8080"
    config.proxy.no_proxy = "localhost,127.0.0.1,192.168.0.0/16,10.0.0.0/8"
  end
  config.vbguest.auto_update=false
  config.vm.box_check_update=false
  boxes.each do|name, addr|
    config.vm.define name do|cfg|
      cfg.vm.network "private_network", ip: addr, virtualbox__intnet: true
      cfg.vm.host_name = "%s.local" % name
      #cfg.vm.provision "shell", path: "install-base.sh"
      cfg.vm.provider "virtualbox" do|vb|
        vb.cpus="1"
        vb.memory="1024"
      end
      case name
        when "master" then
          cfg.vm.provision "shell", path: "install-master.sh"
#        when "slave1","slave2" then
#          cfg.vm.provision "shell", path: "install-slave.sh"
        when "client" then
          cfg.vm.provision "shell", path: "install-client.sh"
      end
    end
  end
end
