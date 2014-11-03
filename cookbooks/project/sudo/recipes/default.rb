prefix = node['authorization']['sudo']['prefix']

package 'sudo' do
  not_if 'which sudo'
end

if node['authorization']['sudo']['include_sudoers_d']
  directory "#{prefix}/sudoers.d" do
    mode    '0755'
    owner   'root'
    group   node['root_group']
  end
end

template "#{prefix}/sudoers" do
  source 'sudoers.erb'
  mode   '0440'
  owner  'root'
  group  node['root_group']
  variables(
    :sudoers_groups    => node['authorization']['sudo']['groups'],
    :sudoers_users     => node['authorization']['sudo']['users'],
    :passwordless      => node['authorization']['sudo']['passwordless'],
    :include_sudoers_d => node['authorization']['sudo']['include_sudoers_d'],
    :agent_forwarding  => node['authorization']['sudo']['agent_forwarding'],
    :sudoers_defaults  => node['authorization']['sudo']['sudoers_defaults'],
    :command_aliases   => node['authorization']['sudo']['command_aliases'],
    :env_keep_add      => node['authorization']['sudo']['env_keep_add'],
    :env_keep_subtract => node['authorization']['sudo']['env_keep_subtract']
  )
end
