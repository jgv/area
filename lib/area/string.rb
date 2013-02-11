class String

  # Public: Convert a string to an area code.
  #
  # Examples
  #
  #   "CT".to_area
  #   # => ["203", "860"]
  #
  # Returns an Array of converted area codes.
  def to_area
    if Area.state_or_territory?(self)
      @area_codes = Area.area_codes.find_all {|row| row[1].upcase == self }.map {|a| a.first }
    end
  end


  # Public: Convert an area code or zipcode to a US state or region.
  #
  # Examples
  #
  #   "646".to_region
  #   #=> NY
  #
  #   "11211".to_region
  #   #=> "Brooklyn, NY",
  #
  # Returns a String of converted area codes or zipcodes.
  def to_region(options = {})
    if self.to_s.length == 3  # an area code
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


  # Public: Convert a place to a zip code.
  #
  # Examples
  #
  #   "long island city, ny".to_zip
  #   #=> ["11101", "11109", "11120"]
  #
  #   "hastings on hudson".to_zip
  #   #=> ["10706"]
  #
  # Returns an Array of converted places.
  def to_zip
    if self.match(',')
      area = self.split(',')
      area.collect! { |a| a.strip }
      @zip_codes = Area.zip_codes.find_all {|row| row[1] && row[1].downcase == area[0].downcase and row[2].downcase == area[1].downcase }.map {|a| a.first }
    else
      @zip_codes = Area.zip_codes.find_all {|row| row[1] != nil and row[1].downcase == self.downcase }.map {|a| a.first }
    end
  end


  # Public: Convert a zipcode to its GMT offset.
  #
  # Examples
  #
  #   "11211".to_gmt_offset
  #   #=> "-5"
  #
  # Returns a String representation of the GMT offset.
  def to_gmt_offset
    if Area.zip_or_territory?(self.to_s)
      row = Area.zip_codes.find {|row| row[2] != nil and (row[2].upcase == self.to_s.upcase or row[0] == self.to_s) }
      row[5] if row
    end
  end


  # Public: Convert a zipcode to its latitude and longitude.
  #
  # Examples
  #
  #   "11211".to_latlon
  #   #=> "40.71209, -73.95427"
  #
  # Returns a String representation of the lat/lon pair.
  def to_latlon
    if Area.zip?(self)
      row = Area.zip_codes.find {|row| row.first == self.to_s }
      row[3] + ', ' + row[4] if row
    end
  end


  # Public: Convert a zipcode to its latitude.
  #
  # Examples
  #
  #   "11211".to_lat
  #   #=> "40.71209"
  #
  # Returns a String representation of the latitude.
  def to_lat
    if Area.zip?(self)
      row = Area.zip_codes.find {|row| row.first == self.to_s }
      row[3] if row
    end
  end


  # Public: Convert a zipcode to its longitude.
  #
  # Examples
  #
  #   "11211".to_lon
  #   #=> "40.71209"
  #
  # Returns a String representation of the longitude.
  def to_lon
    if Area.zip?(self)
      row = Area.zip_codes.find {|row| row.first == self.to_s }
      row[4] if row
    end
  end

end
