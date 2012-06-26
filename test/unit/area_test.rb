require 'minitest/autorun'
require 'area'

class TestInteger < MiniTest::Unit::TestCase
  
  def test_that_it_converts_area_code_to_region
    assert_equal "NY", 646.to_region    
  end
  
  def test_that_it_converts_zip_code_to_region
    assert_equal "Brooklyn, NY", 11211.to_region
  end

  def test_that_it_supports_options
    assert_equal "Brooklyn", 11211.to_region(:city => true)
    assert_equal "NY", 11211.to_region(:state => true)
  end

  def test_that_it_converts_zip_code_to_latlon
    assert_equal "40.71209, -73.95427", 11211.to_latlon
  end

  def test_that_it_converts_zip_code_to_lat
    assert_equal "40.71209", 11211.to_lat
  end

  def test_that_it_converts_zip_code_to_lon
    assert_equal "-73.95427", 11211.to_lon
  end

  def test_that_it_converts_zip_code_to_gmt_offset
    assert_equal "-5", 11211.to_gmt_offset
  end

end

class TestString < MiniTest::Unit::TestCase

  def test_that_it_converts_to_area_code
    assert_equal "907", "AK".to_area
    assert_equal ["203", "860"], "CT".to_area
  end

  def test_that_it_converts_to_zip_code
    assert_equal "10706", "hastings on hudson".to_zip
    assert_equal ["11101", "11109", "11120"], "long Island city".to_zip
  end

  def test_that_it_converts_to_offset
    assert_equal "-5", "ny".to_gmt_offset
  end

end

class TestArray < MiniTest::Unit::TestCase

  def test_that_it_converts_latlon_to_zip_code
    assert_equal "11211", [40.71209, -73.95427].to_zip
  end

  def test_that_it_converts_latlon_to_region
    assert_equal "Brooklyn, NY", [40.71209, -73.95427].to_region
  end

  def test_that_it_converts_latlon_to_region_with_options
    assert_equal "NY", [40.71209, -73.95427].to_region(:state => true)
  end

  def test_that_it_converts_latlon_to_gmt_offset
    assert_equal "-5", [40.71209, -73.95427].to_gmt_offset
  end

end
