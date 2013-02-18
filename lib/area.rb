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

  @regions = ["REGION", "NJ", "DC", "CT", "MB", "AL", "WA", "ME", "ID", "CA", "TX", "NY", "PA", "OH", "IL", "MN", "IN", "LA", "ON", "MS", "GA", "MI", "FL", "Maryland", "BAHAMAS", "BARBADOS", "BC", "NC", "WI", "ANGUILLA", "ANTIGUA AND BARBUDA", "KY", "VA", "BRITISH VIRGIN ISLANDS", "DE", "CO", "WV", "SK", "WY", "NE", "MO", "KS", "IA", "MA", "USVI", "CAYMAN ISLANDS", "RI", "AB", "OK", "MT", "QC", "Tennessee", "UT", "BERMUDA", "RESERVED", "GRENADA", "AR", "AZ", "OR", "NM", "NB", "NH", "SD", "TURKS & CAICOS ISLANDS", "MONTSERRAT", "MP", "GU", "AS", "ND", "NV", "NL", "US GOVERNMENT", "ST. LUCIA", "DOMINICA", "ST. VINCENT & GRENADINES", "PR", "TOLL FREE", "VT", "SC", "HI", "DOMINICAN REPUBLIC", "YT", "TRINIDAD & TOBAGO", "ST. KITTS & NEVIS", "JAMAICA", "TOLL CALLS", "NS", "AK"]

  def self.code?(code)
    if code.to_s.length == 3
      return code
    else
      raise ArgumentError, "You must provide a valid area code", caller
    end
  end

  def self.code_or_zip?(code)
    if code.to_s.length == 3 or code.to_s.length == 5
      return code
    else
      raise ArgumentError, "You must provide a valid area or zip code", caller
    end
  end

  def self.zip?(code)
    if code.to_s.length == 5
      return code
    else
      raise ArgumentError, "You must provide zip code", caller
    end
  end

  def self.state_or_territory?(state)
    if @regions.include?(state.upcase)
      return state
    else
      raise ArgumentError, "You must provide a valid US state abbreviation or territory name", caller
    end
  end

  def self.zip_or_territory?(state)
    if @regions.include?(state.upcase) or Area.zip?(state)
      return state
    else
      raise ArgumentError, "You must provide a valid US state abbreviation or zipcode.", caller
    end
  end


end
