# -*- mode: ruby -*-
# vi: set ft=ruby :
#
#Define the list of machines
cluster = {
    :controller => {
        :hostname => "controller",
        :ipaddress => "10.0.0.100",
	:cpus => "2",
	:memory => "512"
    },
    :node1 => {
        :hostname => "node1",
        :ipaddress => "10.0.0.101",
	:cpus => "1",
	:memory => "512",
    }
    :node2 => {
        :hostname => "node2",
        :ipaddress => "10.0.0.102",
	:cpus => "1",
	:memory => "1024"
}

# inline script
$script = <<SCRIPT
apt -y update
apt -y install foo bar baz
## update hosts file on each?
## munge key sync
## conf files?
SCRIPT

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |global|
	cluster.each_pair do |name,options|
	config.vm.define name do |config|
		#per VM customizations
		config.vm.box = "ubuntu/jammy64"
		config.vm.hostname = "#{name}"
		config.vm.network :private_network, ip: option[:ipaddress]
		config.vm.provider :virtualbox do |v|
			#v.customize ["modifyvm", :id, "--memory", option[:memory]]
			v.cpus = option[:cpus]
			v.memory = option[:memory]
		end
	end
end
