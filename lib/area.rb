require 'csv'

module Area
  DATA = CSV.read(File.open(File.join(File.dirname(__FILE__), '..', 'data', 'areacodes.csv')))
end

class Integer
  def to_region
    Area::DATA.each do |row|
      if row.first == self.to_s
        return row.last
      end
    end
  end
end

class String
  def to_area
    @area_codes = []
    Area::DATA.each do |row|
      if row[1] == self        
        @area_codes.push(row.first)
      end
    end
    @area_codes
  end
end
