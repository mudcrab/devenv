Vagrant.configure('2') do |config|
	config.vm.box = 'debian/testing64'

	config.vm.network 'private_network', ip: '192.168.13.37'

	config.vm.provider 'virtualbox' do |v|
		v.memory = 8096
		v.cpus = 8
	end

	config.vm.hostname = 'dev.khvh.dev'

	config.vm.provision 'shell', path: 'setup.sh'
end
