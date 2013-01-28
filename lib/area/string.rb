class String

  def to_area
    @area_codes = []
    Area.area_codes.each do |row|
      @area_codes.push(row.first) if row[1].upcase == self
    end
    @area_codes.length == 1 ? @area_codes.first : @area_codes
  end

  def to_region(options = {})
    if self.to_s.length == 3 # an area code
      Area.area_codes.each do |row|
        return row.last if row.first == self.to_s
      end
    else # more than 3 digits, assume a zipcode
      Area.zip_codes.each do |row|
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
    nil
  end

  def to_zip
    @zip_codes = []

    if self.match(',')
      @area = self.split(',')
      @area.collect! { |a| a.strip }

      Area.zip_codes.each do |row|
        @zip_codes.push(row[0]) if row[1] && row[1].downcase == @area[0].downcase and row[2].downcase == @area[1].downcase
      end
    else
      Area.zip_codes.each do |row|
        @zip_codes.push(row[0]) if row[1] and row[1].downcase == self.downcase
      end
    end
    @zip_codes.length == 1 ? @zip_codes.first : @zip_codes
  end

  def to_gmt_offset
    Area.zip_codes.each do |row|
      return row[5] if row[2] != nil and
                          (row[2].upcase == self.to_s.upcase or row[0] == self.to_s)
    end
     nil
  end

end
