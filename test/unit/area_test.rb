require 'minitest/autorun'
require 'area'

class TestInteger < MiniTest::Unit::TestCase
  
  def test_that_it_converts_area_code_to_region
    assert_equal "NY", 646.to_region    
  end
  
  def test_that_it_converts_zip_code_to_region
    assert_equal "Brooklyn", 11211.to_region
  end

end

class TestString < MiniTest::Unit::TestCase

  def test_that_it_converts_to_area_code
    assert_equal "907", "AK".to_area.first
    assert_equal ["203", "860"], "CT".to_area
  end

  def test_that_it_converts_to_zip_code
    assert_equal "10706", "hastings on hudson".to_zip
    assert_equal ["11101", "11109", "11120"], "long Island city".to_zip
  end

end
