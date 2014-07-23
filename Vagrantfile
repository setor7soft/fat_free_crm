# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "setor7crm"
  config.vm.box_url = "https://www.dropbox.com/s/07m0zlve0d5jzi1/precise32.box?dl=1"
  config.vm.host_name = 'setor7devbox'

  #config.vm.network :private_network, ip: '192.168.33.10'

  #config.vm.network :forwarded_port, guest: 80, host: 8080
  config.vm.network :forwarded_port, guest: 1080, host: 1080
  config.vm.network :forwarded_port, guest: 3000, host: 3000
  config.vm.network :forwarded_port, guest: 4321, host: 4321

  config.vm.synced_folder ".", "/home/vagrant/setor7crm"

  #config.vm.provision :chef_solo do |chef|
  #  chef.cookbooks_path = 'cookbooks'
  #  chef.add_recipe 'main'
  #end

end
