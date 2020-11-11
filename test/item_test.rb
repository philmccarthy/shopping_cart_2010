require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'

class ItemTest < Minitest::Test
  def test_it_exists_and_has_attributes
    item2 = Item.new({name: 'Tomato', price: '$0.50'})
    assert_equal "Tomato", item2.name
    assert_equal 0.5, item2.price
  end
end
