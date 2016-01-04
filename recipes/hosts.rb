# commom operation among all chef roles
hostsfile_entry '127.0.0.1' do
  hostname 'localhost'
  action :append
  unique true
end

hostsfile_entry node['chefserver']['ip'] do
  hostname node['chefserver']['hostname']
  action :append
  unique true
end

# commom operation among web and db (mysql, percona, maria db cluster)
if node.role?('w_apache_role') || node.role?('w_mysql_role') || node.role?('w_percona_role') || node.chef_environment == "testkitchen" then

  Chef::Log.info("this node apache or db. start configureing hostsfile entry for connection btwn them")

  if node['dbhosts']['webapp_ip'].instance_of?(Chef::Node::ImmutableArray) then
    Chef::Log.info("node['dbhosts']['webapp_ip'] is detected as Array #{node['dbhosts']['webapp_ip']}")
    webapp_ips = node['dbhosts']['webapp_ip']
  else
    Chef::Log.info("node['dbhosts']['webapp_ip'] is detected as non Array #{node['dbhosts']['webapp_ip']}")
    webapp_ips = []
    webapp_ips << node['dbhosts']['webapp_ip']
  end

  if node['dbhosts']['db_ip'].instance_of?(Chef::Node::ImmutableArray) then
    Chef::Log.info("node['dbhosts']['db_ip'] is detected as Array #{node['dbhosts']['db_ip']}")
    db_ips = node['dbhosts']['db_ip']
  else
    Chef::Log.info("node['dbhosts']['db_ip'] is detected as non Array #{node['dbhosts']['db_ip']}")
    db_ips = []
    db_ips << node['dbhosts']['db_ip']
  end

  node['w_common']['web_apps'].each do |web_app|

    webapp_ips.each_with_index do |webapp_ip, index|
      domain = index.to_s + web_app['connection_domain']['webapp_domain']
      hostsfile_entry "#{webapp_ip} for #{web_app['vhost']['main_domain']}" do
        hostname domain
        action :append
        unique true
      end
    end

    db_ips.each_with_index do |db_ip, index|
      domain = index.to_s + web_app['connection_domain']['db_domain']
      hostsfile_entry "#{db_ip} for #{web_app['vhost']['main_domain']}" do
        hostname domain
        action :append
        unique true
      end
    end
  end
end
