require 'minitest/autorun'
require 'area'

class TestInteger < MiniTest::Unit::TestCase

  def test_that_it_converts_area_code_to_region
    assert_equal "New York", 646.to_region
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

  def test_that_it_converts_zip_code_int_to_gmt_offset
    assert_equal "-5", 11211.to_gmt_offset
  end

  def test_that_it_handles_bad_area_codes
    assert_raises(ArgumentError) { 1234.to_region }
    assert_raises(ArgumentError) { 1234.to_latlon }
    assert_raises(ArgumentError) { 1234.to_lat }
    assert_raises(ArgumentError) { 1234.to_lon }
    assert_raises(ArgumentError) { 1234.to_gmt_offset }
  end

end

class TestString < MiniTest::Unit::TestCase

  def test_that_it_converts_area_code_to_region
    assert_equal "New York", "646".to_region
  end

  def test_that_it_converts_zip_code_to_region
    assert_equal "Brooklyn, NY", "11211".to_region
  end

  def test_that_it_supports_options
    assert_equal "Brooklyn", "11211".to_region(:city => true)
    assert_equal "New York", "11211".to_region(:state => true)
  end

  def test_that_it_converts_to_area_code
    assert_equal ["907"], "Alaska".to_area
    assert_equal ["203", "860"], "Connecticut".to_area
  end

  def test_that_it_converts_to_zip_code
    assert_equal ["10706"], "hastings on hudson".to_zip
    assert_equal ["11101", "11109", "11120"], "long Island city".to_zip
  end

  def test_that_it_converts_city_state_to_zip_code
    assert_equal ["11101", "11109", "11120"], "long Island city, ny".to_zip
  end

  def test_that_it_converts_to_offset
    assert_equal "-5", "New York".to_gmt_offset
  end

  def test_that_it_handles_incorrect_zips
    assert_equal [], "9888".to_zip
    assert_raises(ArgumentError) { "9888".to_region }
    assert_raises(ArgumentError) { "9888".to_area }
    assert_raises(ArgumentError) { "9888".to_gmt_offset }
  end

  def test_that_it_converts_zip_code_to_latlon
    assert_equal "40.71209, -73.95427", "11211".to_latlon
  end

  def test_that_it_converts_zip_code_to_lat
    assert_equal "40.71209", "11211".to_lat
  end

  def test_that_it_converts_zip_code_to_lon
    assert_equal "-73.95427", "11211".to_lon
  end

  def test_that_it_converts_zip_code_to_gmt_offset
    assert_equal "-5", "11211".to_gmt_offset
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
    assert_equal "New York", [40.71209, -73.95427].to_region(:state => true)
  end

  def test_that_it_converts_latlon_to_gmt_offset
    assert_equal "-5", [40.71209, -73.95427].to_gmt_offset
  end

  def test_that_it_handles_latlon_precision
    assert_equal "11211", [40.71209123228157, -73.95488409019887].to_zip
  end

  def test_that_it_handles_incorrect_values
    assert_nil [12.12345, -40.23423].to_zip
    assert_nil [12.12345, -40.23423].to_region
    assert_nil [12.12345, -40.23423].to_gmt_offset
  end

end
