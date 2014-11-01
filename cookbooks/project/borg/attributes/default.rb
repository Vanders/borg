case node.current_user
when 'root'
  default['borg']['root'] = '/opt/borg'
  default['borg']['backup_dir'] = "#{node.borg.root}/backups"
  default['borg']['binary_dir'] = "#{node.borg.root}/bin"
  default['borg']['cache_dir'] = "#{node.borg.root}/cache"
  default['borg']['cookbooks'] = "#{node.borg.root}/cookbooks"
  default['borg']['env_d'] = "#{node.borg.root}/env.d"
  default['borg']['log_dir'] = "#{node.borg.root}/logs"
else
  default['borg']['root'] = "#{node.etc.passwd[node.current_user].dir}/.borg"
  default['borg']['backup_dir'] = "#{node.borg.root}/backups"
  default['borg']['binary_dir'] = "#{node.borg.root}/bin"
  default['borg']['cache_dir'] = "#{node.borg.root}/cache"
  default['borg']['cookbooks'] = "#{node.borg.root}/cookbooks"
  default['borg']['env_d'] = "#{node.borg.root}/env.d"
  default['borg']['log_dir'] = "#{node.borg.root}/logs"
end
