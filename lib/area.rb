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
    AREA_CODES = CSV.read(area_path)
    ZIP_CODES = CSV.read(zip_path)
  else
    AREA_CODES = FasterCSV.parse(area_path)
    ZIP_CODES = FasterCSV.parse(zip_path)
  end
end
