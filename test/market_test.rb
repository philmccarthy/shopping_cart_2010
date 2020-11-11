require 'minitest/autorun'
require 'minitest/pride'
require './lib/market'
require './lib/vendor'
require './lib/item'

class MarketTest < Minitest::Test
  def test_it_exists_and_has_attributes
    market = Market.new("South Pearl Street Farmers Market")
    assert_instance_of Market, market
    asset_equal "South Pearl Street Farmers Market", market.name
    assert_equal [], market.vendors
  end
end
