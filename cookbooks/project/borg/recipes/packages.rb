include_recipe 'homebrew'

casks = data_bag_item('packages', 'default')['caskroom'] + \
         { 'homebrew' => [] }.merge(data_bag_item_if_exists('packages', node.current_user, []))['caskroom']

packages = data_bag_item('packages', 'default')['homebrew'] + \
            { 'homebrew' => [] }.merge(data_bag_item_if_exists('packages', node.current_user, []))['homebrew']

taps = data_bag_item('packages', 'default')['taps'] + \
        { 'homebrew' => [] }.merge(data_bag_item_if_exists('packages', node.current_user, []))['taps']

taps.each do |name|
  homebrew_tap name
end

packages.each do |name|
  package name
end

package 'brew-cask' do
  action :install
end

casks.each do |name|
  homebrew_cask name
end
