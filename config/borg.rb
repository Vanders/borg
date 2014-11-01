borg_homedir = "#{Dir.home}/.borg"
current_dir = Dir.pwd

cookbook_path [
  "#{borg_homedir}/cookbooks",
  "#{current_dir}/cookbooks/project",
  "#{current_dir}/cookbooks/upstream"
]

data_bag_path    "#{current_dir}/data_bags"
environment_path "#{current_dir}/environments"
role_path        "#{current_dir}/roles"
json_attribs     "#{current_dir}/config/dna.json"

log_max_age      3
log_level        :info
log_location     "#{borg_homedir}/logs/chef-client-#{Time.now.to_i}.log"
verbose_logging  true

ssl_verify_mode  :verify_peer
verify_api_cert  true

cache_type       "BasicFile"
file_cache_path	 "#{borg_homedir}/cache"
file_backup_path "#{borg_homedir}/backups"
