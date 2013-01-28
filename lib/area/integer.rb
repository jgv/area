class Integer

  def to_region(options = {})
    if Area.code?(self) # presume an area code
      row = Area.area_codes.find{|row| row.first == self.to_s }
      row.last if row
    end
  end

  def to_latlon
    if Area.code_or_zip?(self)
      row = Area.zip_codes.find {|row| row.first == self.to_s }
      row[3] + ', ' + row[4] if row
    end
  end

  def to_lat
    if Area.code_or_zip?(self)
      row = Area.zip_codes.find {|row| row.first == self.to_s }
      row[3] if row
    end
  end

  def to_lon
    if Area.code_or_zip?(self)
      row = Area.zip_codes.find {|row| row.first == self.to_s }
      row[4] if row
    end
  end

  def to_gmt_offset
    if Area.code_or_zip?(self)
      row = Area.zip_codes.find {|row| row.first == self.to_s }
      row[5] if row
    end
  end

end
