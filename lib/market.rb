require 'date'

class Market
  attr_reader :name,
              :vendors,
              :date
  def initialize(name)
    @name = name
    @vendors = []
    @date = Date.today.strftime("%d/%m/%Y")
  end

  def add_vendor(vendor)
    vendors.push(vendor)
  end

  def vendor_names
    vendors.map do |vendor|
      vendor.name
    end
  end

  def vendors_that_sell(item)
    vendors.select do |vendor|
      vendor.check_stock(item) > 0
    end
  end

  def total_inventory
    breakout = Hash.new { |breakout, item| breakout[item] = {quantity: 0, vendors: nil} }
    vendors.each do |vendor|
      vendor.inventory.each do |item, qty|
        breakout[item][:quantity] += qty
        breakout[item][:vendors] = vendors_that_sell(item)
      end
    end
    breakout
  end

  def overstocked_items
    total_inventory.select do |item, details|
      item if vendors_that_sell(item).size > 1 &&
      details[:quantity] > 50
    end.keys
  end

  def sorted_item_list
    total_inventory.keys.map do |item|
      item.name
    end.uniq.sort
  end

  def unsellable?(item, qty)
    total_inventory[item][:quantity] < qty ||
    vendors_that_sell(item).nil?
  end

end
