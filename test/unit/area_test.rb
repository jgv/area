require 'minitest/autorun'
require 'area'

class TestNumeric < MiniTest::Unit::TestCase

  def test_that_it_converts_to_region
    assert_equal "NY", 646.to_region    
  end
  
end
