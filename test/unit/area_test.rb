require 'minitest/autorun'
require 'minitest/benchmark' if ENV["BENCH"]
require 'minitest/pride'
require File.expand_path('../../../lib/area.rb', __FILE__)

class TestInteger < MiniTest::Unit::TestCase

  def test_that_it_converts_area_code_to_region
    assert_equal "NY", 646.to_region
  end

  def test_that_it_handles_bad_area_codes
    assert_raises(ArgumentError) { 1234.to_region }
    assert_raises(ArgumentError) { 1234.to_latlon }
    assert_raises(ArgumentError) { 1234.to_lat }
    assert_raises(ArgumentError) { 1234.to_lon }
  end

  # Benchmarks

  def bench_to_region
    assert_performance_constant 0.9999 do |n|
      n.times { 646.to_region }
    end
  end

end

class TestString < MiniTest::Unit::TestCase

  def test_that_it_converts_area_code_to_region
    assert_equal "NY", "646".to_region
  end

  def test_that_it_converts_zip_code_to_region
    assert_equal "Brooklyn, NY", "11211".to_region
  end

  def test_that_it_supports_options_for_zipcodes
    assert_equal "Brooklyn", "11211".to_region(:city => true)
    assert_equal "NY", "11211".to_region(:state => true)
  end

  def test_that_it_converts_to_area_code
    assert_equal ["907"], "AK".to_area
    assert_equal ["203", "860"], "CT".to_area
  end

  def test_that_it_converts_to_zip_code
    assert_equal ["10706"], "hastings on hudson".to_zip
    assert_equal ["11101", "11109", "11120"], "long Island city".to_zip
  end

  def test_that_it_converts_city_state_to_zip_code
    assert_equal ["11101", "11109", "11120"], "long Island city, ny".to_zip
  end

  def test_that_it_handles_incorrect_zips
    assert_equal [], "9888".to_zip
    assert_raises(ArgumentError) { "9888".to_region }
    assert_raises(ArgumentError) { "9888".to_area }
  end

  def test_that_it_converts_zip_code_to_latlon
    assert_equal "40.7095, -73.9563", "11211".to_latlon
  end

  def test_that_it_converts_zip_code_to_lat
    assert_equal "40.7095", "11211".to_lat
  end

  def test_that_it_converts_zip_code_to_lon
    assert_equal "-73.9563", "11211".to_lon
  end

  # Benchmarks

  def bench_area_code_to_region
    assert_performance_constant 0.9999 do |n|
      n.times { "646".to_region }
    end
  end

  def bench_zip_code_to_region
    assert_performance_constant 0.9999 do |n|
      n.times { "11211".to_region }
    end
  end

  def bench_zip_code_to_region_with_state_option
    assert_performance_constant 0.9999 do |n|
      n.times { "11211".to_region(:state => true) }
    end
  end

  def bench_zip_code_to_region_with_city_option
    assert_performance_constant 0.9999 do |n|
      n.times { "11211".to_region(:city => true) }
    end
  end

  def bench_to_area_code
    assert_performance_constant 0.9999 do |n|
      n.times { "NY".to_area }
    end
  end

  def bench_to_zip_code
    assert_performance_constant 0.9999 do |n|
      n.times { "long island city".to_zip }
    end
  end

  def bench_city_state_to_zip_code
    assert_performance_constant 0.9999 do |n|
      n.times { "long island city, ny".to_zip }
    end
  end
end

class TestArray < MiniTest::Unit::TestCase
  def test_that_it_converts_latlon_to_zip_code
    assert_equal "11211", ["40.7095", "-73.9563"].to_zip
  end

  def test_that_it_converts_latlon_to_region
    assert_equal "Brooklyn, NY", ["40.7095", "-73.9563"].to_region
  end

  def test_that_it_converts_latlon_to_region_with_options
    assert_equal "NY", ["40.7095", "-73.9563"].to_region(:state => true)
  end

  def test_that_it_handles_latlon_precision
    assert_equal "11211", ["40.70959123228157", "-73.95638409019887"].to_zip
  end

  def test_that_it_handles_incorrect_values
    assert_nil ["12.12345", "-40.23423"].to_zip
    assert_nil ["12.12345", "-40.23423"].to_region
  end

  # Benchmarks

  def bench_to_zip_code
    assert_performance_constant 0.9999 do |n|
      n.times { ["40.71209", "-73.95427"].to_zip }
    end
  end

  def bench_to_region
    assert_performance_constant 0.9999 do |n|
      n.times { ["40.71209", "-73.95427"].to_region }
    end
  end

  def bench_to_region_with_options
    assert_performance_constant 0.9999 do |n|
      n.times { ["40.71209", "-73.95427"].to_region(:state => true) }
    end
  end

  def bench_precision_handling
    assert_performance_constant 0.9999 do |n|
      n.times { ["40.71209123228157", "-73.95488409019887"].to_zip }
    end
  end
end

class TestArea < MiniTest::Unit::TestCase
  def test_that_regions_is_an_array
    assert_instance_of Array, Area.regions
  end
end
