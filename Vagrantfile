Vagrant.require_version ">= 2.1.1"

ENV["LC_ALL"] = "en_US.UTF-8"

Vagrant.configure("2") do |config|
	config.vm.box = "debian/stretch64"
	config.vm.box_version = "9.8.0"
	config.vm.hostname = "wp-minimal-error"
	config.vm.network :private_network, ip: "192.168.27.255"
	config.vm.synced_folder ".", "/vagrant", type: "virtualbox"
	config.vm.network "forwarded_port", guest: 8000, host: 8000, id: "wordpress"
	config.vm.network "forwarded_port", guest: 8080, host: 8008, id: "phpmyadmin"
	config.vm.network "forwarded_port", guest: 8081, host: 8009, id: "adminer"
	config.vm.provision "shell", path: "postinstall.sh"
end
