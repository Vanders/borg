begin
  data_bag_item_if_exists('snowflake', node.current_user, {})["run_list"].each do |rl|
    include_recipe rl
  end
rescue
  # Nothing to see here, carry on!
end

begin
  include_recipe "snowflake::#{node.current_user}"
rescue Chef::Exceptions::RecipeNotFound => rnfe
  warn "No custom recipe (snowflake::#{node.current_user}) was found."
end
