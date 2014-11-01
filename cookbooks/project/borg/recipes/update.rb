node.default['borg']['repository'] = 'https://github.com/agh/borg'

case node.current_user
when 'root'
  node.default['borg']['root'] = '/opt/borg'
  node.default['borg']['source_dir'] = "#{node.borg.root}/src"
else
  node.default['borg']['root'] = "#{node.etc.passwd[node.current_user].dir}/.borg"
  node.default['borg']['source_dir'] = "#{node.borg.root}/src"
end

directory node.borg.source_dir do
  owner node.current_user
  group node.current_user
  mode '0700'
end

git node.borg.source_dir do
  repository node.borg.repository
  revision 'master'
  action :sync
end
