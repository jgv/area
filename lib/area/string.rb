class String
  def to_area
    @area_codes = []
    Area::AREA_CODES.each do |row|
      if row[1].upcase == self        
        @area_codes.push(row.first)
      end
    end
    if @area_codes.length == 1
      return @area_codes.first
    else
      return @area_codes
    end
  end

  def to_zip
    @zip_codes = []

    if self.match(',')
      @area = self.split(',')
      @area.collect! { |a| a.strip }

      Area::ZIP_CODES.each do |row|
        if row[1] && row[1].downcase == @area[0].downcase && row[2].downcase == @area[1].downcase
          @zip_codes.push(row[0])
        end
      end
    else
      Area::ZIP_CODES.each do |row|
        if row[1] and row[1].downcase == self.downcase
          @zip_codes.push(row[0])
        end
      end
    end

    if @zip_codes.length == 1
      return @zip_codes.first
    else
      return @zip_codes
    end
  end

  def to_gmt_offset
    Area::ZIP_CODES.each do |row|
      if row[2].upcase == self.to_s.upcase
        return row[5]
      end      
    end
  end
end
