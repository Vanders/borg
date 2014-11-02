begin
  data_bag_item_if_exists('snowflake', node.current_user, {})["run_list"].each do |rl|
    begin
      include_recipe rl
    rescue
      warn "Snowflake :: Whilst trying to load '#{rl}' some shit went wrong. It was not included."
    end
  end
rescue
  # Nothing to see here, carry on!
end
