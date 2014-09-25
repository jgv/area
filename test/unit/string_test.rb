require 'minitest/autorun'
require File.expand_path('../../../lib/area.rb', __FILE__)

class TestString < MiniTest::Unit::TestCase
  def test_that_it_converts_zip_code_to_full_state
    assert_equal 'New York', '10001'.to_region(full_state: true)
  end
end
