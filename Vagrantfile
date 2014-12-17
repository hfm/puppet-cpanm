# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "hfm4/centos6"

  config.vm.provision :shell, path: "setup.sh"
  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path = "."
    puppet.manifest_file  = "manifests/init.pp"
    puppet.options = "--verbose --show_diff"
  end
end
