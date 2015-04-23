Vagrant.configure("2") do |config|
  config.vm.hostname = "wrapper-test"
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.network :private_network, ip: "33.33.33.10"
  config.ssh.max_tries = 40
  config.ssh.timeout   = 120
  config.omnibus.chef_version = '10.24.0'
  config.berkshelf.enabled = true

  config.vm.provision :chef_solo do |chef|
        chef.json = {
          'scope' => 'test',
          'site' => 'sitetest',
          'project' => 'projtest',
          "resolver" => {
            "search" => "my.net",
            "nameservers" => ["8.8.8.8"],
            "options" => {
              "timeout" => 2, "rotate" => nil
            }
          }
        }
    chef.run_list = [
         "recipe[chef-mongodb::replicaset]"
    ]
  end

end
