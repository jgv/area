if RUBY_VERSION.to_f >= 1.9 # ;_;
  require 'csv'
else
  require 'rubygems'
  require 'faster_csv'
end

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
      
class Integer
  def to_region(options = {})
    if self.to_s.length == 3 # an area code
      Area::AREA_CODES.each do |row|
        if row.first == self.to_s
          return row.last
        end
      end
    else # more than 3 digits, assume a zipcode
      Area::ZIP_CODES.each do |row|
        if row.first == self.to_s
          if options[:city]
            return row[1]
          elsif options[:state]
            return row[2]
          else
            return row[1] + ', ' + row[2]
          end
        end
      end
    end
  end

  def to_latlon
    Area::ZIP_CODES.each do |row|
      if row.first == self.to_s
        return row[3] + ', ' + row[4]
      end
    end
  end

  def to_lat
    Area::ZIP_CODES.each do |row|
      if row.first == self.to_s
        return row[3]
      end
    end
  end

  def to_lon
    Area::ZIP_CODES.each do |row|
      if row.first == self.to_s
        return row[4]
      end
    end
  end

  def to_gmt_offset
    Area::ZIP_CODES.each do |row|
      if row.first == self.to_s
        return row[5]
      end
    end
  end

end

class String
  def to_area
    @area_codes = []
    Area::AREA_CODES.each do |row|
      if row[1].upcase == self        
        @area_codes.push(row.first)
      end
    end
    if @area_codes.length == 1
      return @area_codes.first
    else
      return @area_codes
    end
  end

  def to_zip
    @zip_codes = []
    Area::ZIP_CODES.each do |row|
      if row[1] and row[1].downcase == self.downcase
        @zip_codes.push(row.first)
      end
    end
    if @zip_codes.length == 1
      return @zip_codes.first
    else
      return @zip_codes
    end
  end

  def to_gmt_offset
    Area::ZIP_CODES.each do |row|
      if row[2].upcase == self.to_s.upcase
        return row[5]
      end      
    end
  end

end
