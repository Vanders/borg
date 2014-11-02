begin
  include_recipe "snowflake::#{node.current_user}"
rescue Chef::Exceptions::RecipeNotFound => rnfe
  warn "Snowflake :: No custom recipe (snowflake::#{node.current_user}) was found. Not including anything."
end
