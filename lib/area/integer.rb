class Integer

  def to_region(options = {})
    if self.to_s.length == 3 # an area code
      Area::AREA_CODES.each do |row|
        if row.first == self.to_s
          return row.last
        end
      end
    else
      # puts "not an area code"
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
