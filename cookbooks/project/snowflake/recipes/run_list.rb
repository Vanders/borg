begin
  data_bag_item_if_exists('snowflake', node.current_user, {})["run_list"].each do |rl|
    include_recipe rl
  end
rescue
  # Nothing to see here, carry on!
end
