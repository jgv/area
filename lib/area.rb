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

  @regions = ["REGION", "New Jersey", "DC", "Connecticut", "MB", "Alabama", "Washington", "Maine", "Idaho", "California", "Texas", "New York", "Pennsylvania", "Ohio", "Illinois", "Minnesota", "Indiana", "Louisiana", "ON", "Mississippi", "Georgia", "Michigan", "Florida", "Maryland", "BAHAMAS", "BARBADOS", "BC", "North Carolina", "Wisconsin", "ANGUILLA", "ANTIGUA AND BARBUDA", "Kentucky", "Virginia", "BRITISH VIRGIN ISLANDS", "Delaware", "Colorado", "West Virginia", "SK", "Wyoming", "Nebraska", "Missouri", "Kansas", "Iowa", "Massachusetts", "USVI", "CAYMAN ISLANDS", "Rhode Island", "AB", "Oklahoma", "Montana", "QC", "Tennessee", "Utah", "BERMUDA", "RESERVED", "GRENADA", "Arkansas", "Arizona", "Oregon", "New Mexico", "NB", "New Hampshire", "South Dakota", "TURKS & CAICOS ISLANDS", "MONTSERRAT", "MP", "GU", "AS", "North Dakota", "Nevada", "NL", "US GOVERNMENT", "ST. LUCIA", "DOMINICA", "ST. VINCENT & GRENADINES", "PR", "TOLL FREE", "Vermont", "South Carolina", "Hawaii", "DOMINICAN REPUBLIC", "YT", "TRINIDAD & TOBAGO", "ST. KITTS & NEVIS", "JAMAICA", "TOLL CALLS", "NS", "Alaska", "NJ", "CT", "AL", "WA", "ME", "ID", "CA", "TX", "NY", "PA", "OH", "IL", "MN", "IN", "LA", "MS", "GA", "MI", "FL", "MD", "NC", "WI", "KY", "VA", "DE", "CO", "WV", "WY", "NE", "MO", "KS", "IA", "MA", "RI", "OK", "MT", "TN", "UT", "AR", "AZ", "OR", "NM", "NH", "SD", "ND", "NV", "VT", "SC", "HI", "AK"]

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
