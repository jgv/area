class Integer


  # Public: Convert an area code or to a US state or region.
  #
  # Examples
  #
  #   646.to_region
  #   #=> NY
  #
  # Returns a String representation of the converted area code.
  def to_region(options = {})
    if Area.code?(self) # presume an area code
      row = Area.area_codes.find{|row| row.first == self.to_s }
      row.last if row
    end
  end


  # Public: Convert an area code or zipcode to its latitude and longitude.
  #
  # Examples
  #
  #   11211.to_latlon
  #   #=> "40.71209, -73.95427"
  #
  # Returns a String representation of the lat/lon pair.
  def to_latlon
    if Area.zip?(self)
      warn "[DEPRECATION] using `to_latlon` with an integer representation of a zipcode is deprecated and will be removed in future versions. Please use a string instead."
      row = Area.zip_codes.find {|row| row.first == self.to_s }
      row[3] + ', ' + row[4] if row
    end
  end


  # Public: Convert a zipcode to its latitude.
  #
  # Examples
  #
  #   11211.to_lat
  #   #=> "40.71209"
  #
  # Returns a String representation of the latitude.
  def to_lat
    if Area.zip?(self)
      warn "[DEPRECATION] using `to_lat` with an integer representation of a zipcode is deprecated and will be removed in future versions. Please use a string instead."
      row = Area.zip_codes.find {|row| row.first == self.to_s }
      row[3] if row
    end
  end


  # Public: Convert a zipcode to its longitude.
  #
  # Examples
  #
  #   11211.to_lon
  #   #=> "40.71209"
  #
  # Returns a String representation of the longitude.
  def to_lon
    if Area.zip?(self)
      warn "[DEPRECATION] using `to_lon` with an integer representaion of a zipcode is deprecated and will be removed in future versions. Please use a string instead."
      row = Area.zip_codes.find {|row| row.first == self.to_s }
      row[4] if row
    end
  end


  # Public: Convert a zipcode to its GMT offset.
  #
  # Examples
  #
  #   11211.to_gmt_offset
  #   #=> "-5"
  #
  # Returns a String representation of the GMT offset.
  def to_gmt_offset
    if Area.zip?(self)
      warn "[DEPRECATION] using `to_gmt` with an integer representaion of a zipcode is deprecated and will be removed in future versions. Please use a string instead."
      row = Area.zip_codes.find {|row| row.first == self.to_s }
      row[5] if row
    end
  end

end
