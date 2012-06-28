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
    Area::ZIP_CODES.each do |row|
      if row[3] == self[0].to_s and row[4] == self[1].to_s
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
