class Chef
  class Recipe
    # This can be used in place of `data_bag_item` to retrieve things from a
    # data bag which might not exist. Optionally specify default, this is what
    # any requests *for any key with no value* in this data bag item will return.
    # Hat tip and :zap: to @lstoll for actually thinking this approach up.
    def data_bag_item_if_exists(bag, item, default = nil)
      if data_bag(bag).include?(item)
        data_bag_item(bag, item)
      else
        Hash.new(default)
      end
    end
  end
end
