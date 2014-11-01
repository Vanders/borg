overrides = data_bag_item_if_exists("snowflake", node.current_user, {})["overrides"]
node.override = Chef::Mixin::DeepMerge.merge(node.override, Hash(overrides))
