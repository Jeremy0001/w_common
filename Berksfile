# -*- mode: ruby -*-
# vi: set ft=ruby :
source 'https://supermarket.chef.io'

cookbook 'ubuntu'
cookbook 'apt'
cookbook 'apt-repo', git: 'https://github.com/sometimesfood/chef-apt-repo.git'
cookbook 'git'
cookbook 'monit', git: 'https://github.com/phlipper/chef-monit.git'
cookbook 'firewall', "~> 1.4.0"
cookbook 'ntp'
cookbook 'sudo'
cookbook 'timezone-ii'
cookbook 'windows', git: 'https://github.com/opscode-cookbooks/windows.git', ref: '0dae7405020b1521b61170267fdeedc022c3a448'
cookbook 'hostname'

group :wrapper do
  cookbook 'w_common', path: './'
end
