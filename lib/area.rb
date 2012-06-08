require 'csv'

module Area
  DATA = CSV.read(File.open(File.join(File.dirname(__FILE__), '..', 'data', 'areacodes.csv')))
end

class Integer
  def to_region
    Area::DATA.each do |row|
      r = Regexp.new("#{self}")
      return row[1] if r.match(row[0])
    end
  end
end
