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
      item if overstocked?(item)
    end.keys
  end

  def overstocked?(item)
    vendors_that_sell(item).size > 1 &&
    total_inventory[item][:quantity] > 50
  end

  def sorted_item_list
    total_inventory.keys.map do |item|
      item.name
    end.uniq.sort
  end

  def sell(item, qty_to_sell)
    return false if unsellable?(item, qty_to_sell)
    trickle_sell(item, qty_to_sell)
    true
  end

  def unsellable?(item, qty_to_sell)
    item_inventory(item) < qty_to_sell ||
    vendors_that_sell(item).nil?
  end

  def item_inventory(item)
    total_inventory[item][:quantity]
  end

  def trickle_sell(item, qty_to_sell)
    vendors_that_sell(item).each do |vendor|
      until vendor.out_of_stock?(item) || qty_to_sell == 0
        vendor.stock(item, -1)
        qty_to_sell -= 1
      end
    end
  end
end
