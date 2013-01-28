class String

  def to_area
    @area_codes = Area.area_codes.find_all {|row| row[1].upcase == self }.map {|a| a.first }
    @area_codes.length == 1 ? @area_codes.first : @area_codes
  end

  def to_region(options = {})
    if self.to_s.length == 3 # an area code
      row = Area.area_codes.find {|row| row.first == self.to_s }
      return row.last if row
    elsif self.to_s.length == 5
      if row = Area.zip_codes.find {|row| row.first == self.to_s }
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
    else
      raise ArgumentError, "You must provide a valid area or zip code", caller
    end
  end

  def to_zip
    if self.match(',')
      @area = self.split(',')
      @area.collect! { |a| a.strip }

      @zip_codes = Area.zip_codes.find_all {|row| row[1] && row[1].downcase == @area[0].downcase and row[2].downcase == @area[1].downcase }.map {|a| a.first }
    else
      @zip_codes = Area.zip_codes.find_all {|row| row[1] != nil and row[1].downcase == self.downcase }.map {|a| a.first }
    end
    @zip_codes.length == 1 ? @zip_codes.first : @zip_codes
  end

  def to_gmt_offset
    row = Area.zip_codes.find {|row| row[2] != nil and (row[2].upcase == self.to_s.upcase or row[0] == self.to_s) }
    row[5] if row
  end

end
