class Array

  def to_region(options = {})
    Area.zip_codes.each do |row|
      if row[3] == self[0].to_s and row[4] == self[1].to_s
        if options[:city]
          return row[1]
        elsif options[:state]
          return row[2]
        else
          return row[1] + ', ' + row[2]
        end
      end
    end
    nil
  end

  def to_zip
    Area.zip_codes.each do |row|
      if row[3] and row[4]
        db_lat_len = row[3].split('.').length
        db_lon_len = row[4].split('.').length
        lat = "%.#{db_lat_len}f" % self[0]
        lon = "%.#{db_lon_len}f" % self[1]
        db_lat = "%.#{db_lat_len}f" % row[3].to_f
        db_lon = "%.#{db_lon_len}f" % row[4].to_f
        if db_lat.to_s == lat.to_s and db_lon.to_s == lon.to_s
          return row[0]
        end
      end
    end
    nil
  end

  def to_gmt_offset
    Area.zip_codes.each do |row|
      if row[3] == self[0].to_s and row[4] == self[1].to_s
        return row[5]
      end
    end
    nil
  end

end
