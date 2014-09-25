if RUBY_VERSION.to_f >= 1.9 # ;_;
  require 'csv'
else
  require 'rubygems'
  require 'faster_csv'
end

require 'area/array'
require 'area/integer'
require 'area/string'

module Area

  zip_path = File.open(File.join(File.dirname(__FILE__), '..', 'data', 'zipcodes.csv'))
  area_path = File.open(File.join(File.dirname(__FILE__), '..', 'data', 'areacodes.csv'))

  module ZIP
    ZIPCODE = 0
    CITY = 1
    STATE = 2
    LONGITUTE = 3
    LATITUTE = 4
    GMT_OFFSET = 5
    DAYLIGHT_SAVING = 6
  end

  module AREA
    AREA_CODE = 0
    STATE = 1
  end

  # there is probably a better way to do this...
  if RUBY_VERSION.to_f >= 1.9
    @area_codes = CSV.read(area_path)
    @zip_codes = CSV.read(zip_path)
  else
    @area_codes = FasterCSV.parse(area_path)
    @zip_codes = FasterCSV.parse(zip_path)
  end

  def self.area_codes
    @area_codes
  end

  def self.zip_codes
    @zip_codes
  end

  def self.regions
    @area_codes.inject([]) {|regions, row| regions << row.last.upcase }
  end

  def self.code?(code)
    if code.to_s.length == 3
      code
    else
      raise ArgumentError, "You must provide a valid area code", caller
    end
  end

  def self.code_or_zip?(code)
    if code.to_s.length == 3 || code.to_s.length == 5
      code
    else
      raise ArgumentError, "You must provide a valid area or zip code", caller
    end
  end

  def self.zip?(code)
    if code.to_s.length == 5
      code
    else
      raise ArgumentError, "You must provide zip code", caller
    end
  end

  def self.state_or_territory?(state)
    if self.regions.include?(state.upcase)
      state
    else
      raise ArgumentError, "You must provide a valid US state abbreviation or territory name", caller
    end
  end

  def self.zip_or_territory?(state)
    if self.regions.include?(state.upcase) || self.zip?(state)
      state
    else
      raise ArgumentError, "You must provide a valid US state abbreviation or zipcode.", caller
    end
  end


end
