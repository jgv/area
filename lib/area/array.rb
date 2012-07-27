class Array

  def to_region(options = {})
    Area::ZIP_CODES.each do |row|
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
  end

  def to_zip
    lat = '%.3f' % self[0]
    lon = '%.3f' % self[1]

    Area::ZIP_CODES.each do |row|
      db_lat = '%.3f' % row[3].to_f
      db_lon = '%.3f' % row[4].to_f

      if db_lat.to_s == lat.to_s and db_lon.to_s == lon.to_s
        return row[0]
      end
    end
  end

  def to_gmt_offset
    Area::ZIP_CODES.each do |row|
      if row[3] == self[0].to_s and row[4] == self[1].to_s
        return row[5]
      end
    end
  end
end
