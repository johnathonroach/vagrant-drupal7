#Set the desired ip address for your site
$ip_address = "192.168.55.91" #use whatever ip you like, then set it up in your host file! holy crap!
#Buid vm and run setup.sh
Vagrant.configure("2") do |config|
  config.vm.box="ubuntu/trusty64"
  config.vm.box_url="https://atlas.hashicorp.com/ubuntu/boxes/trusty64"
  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--memory", "1024"]
    v.customize ["modifyvm", :id, "--cpus", 1]
  end
  config.vm.synced_folder "../../../","/var/www/", type: "nfs"
  config.vm.define "vagrantDrupal7Trusty64" do |vagrantDrupal7Trusty64|
  end
  config.vm.network :private_network, ip: $ip_address
  config.vm.provision :file do |file|
    file.source      = 'dev'
    file.destination = '/tmp/dev'
  end
  config.vm.provision :file do |file|
    file.source      = 'htaccess'
    file.destination = '/tmp/htaccess'
  end
  config.vm.provision "shell", path: "setup.sh"
end
