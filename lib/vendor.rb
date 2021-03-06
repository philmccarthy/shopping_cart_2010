class Vendor
  attr_reader :name,
              :inventory

  def initialize(name)
    @name = name
    @inventory = Hash.new { |inventory, item| inventory[item] = 0 }
  end

  def check_stock(item)
    inventory[item]
  end

  def out_of_stock?(item)
    inventory[item] == 0
  end

  def in_stock?(item)
    !out_of_stock?(item)
  end

  def stock(item, qty)
    inventory[item] += qty
  end

  def potential_revenue
    inventory.sum do |item, qty|
      item.price * qty
    end
  end
end
