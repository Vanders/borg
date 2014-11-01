# include_recipe "borg::update"

directory node.borg.root do
  owner node.current_user
  group node.current_user
  mode '0700'
end

directory node.borg.backup_dir do
  owner node.current_user
  group node.current_user
  mode '0700'
end

directory node.borg.binary_dir do
  owner node.current_user
  group node.current_user
  mode '0700'
end

directory node.borg.cookbooks do
  owner node.current_user
  group node.current_user
  mode '0700'
end

directory node.borg.cache_dir do
  owner node.current_user
  group node.current_user
  mode '0700'
end

directory node.borg.env_d do
  owner node.current_user
  group node.current_user
  mode '0700'
end

directory node.borg.log_dir do
  owner node.current_user
  group node.current_user
  mode '0700'
end

cookbook_file "#{node.borg.binary_dir}/borg" do
  mode '0700'
  source 'borg'
end

link '/usr/local/bin/borg' do
  to "#{node.borg.binary_dir}/borg"
end

cookbook_file "#{node.borg.binary_dir}/borg_env" do
  mode '0700'
  source 'borg_env'
end

link '/usr/local/bin/borg_env' do
  to "#{node.borg.binary_dir}/borg_env"
end
