if RUBY_VERSION.to_i == 1.8
  require 'rubygems'
  require 'faster_csv'
else
  require 'csv'
end

module Area
  AREA_CODES = CSV.read(File.open(File.join(File.dirname(__FILE__), '..', 'data', 'areacodes.csv')))
  ZIP_CODES = CSV.read(File.open(File.join(File.dirname(__FILE__), '..', 'data', 'zipcodes.csv')))
end

class Integer
  def to_region

    if self.to_s.length == 3
      Area::AREA_CODES.each do |row|
        if row.first == self.to_s
          return row.last
        end
      end
    else
      Area::ZIP_CODES.each do |row|
        if row.first == self.to_s
          return row[1]
        end
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
    @area_codes
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
end
