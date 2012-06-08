require 'minitest/autorun'
require 'area'

class TestInteger < MiniTest::Unit::TestCase
  
  def test_that_it_converts_to_region
    assert_equal "NY", 646.to_region    
  end
  
end

class TestString < MiniTest::Unit::TestCase

  def test_that_it_converts_to_area_code
    assert_equal "907", "AK".to_area.first
    assert_equal ["203", "860"], "CT".to_area
  end

end
