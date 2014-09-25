class Array

  # Public: Convert an lat/lon pair as an Array to a region.
  #
  # options - An optional hash indicating if you would like just the city or just the state.
  #
  # Examples
  #
  #   ['40.71209', '-73.95427'].to_region
  #   # => "Brooklyn, NY"
  #
  #   ['40.71209', '-73.95427'].to_region(:state => true)
  #   # => "NY"
  #
  # Returns a String representation of the lat/lon pair.
  def to_region(options = {})
    if self[0].is_a?(String) && self[1].is_a?(String)
      if row = Area.zip_codes.find {|row| row[Area::ZIP::LONGITUTE] == self[0].to_s && row[Area::ZIP::LATITUTE] == self[1].to_s }
        if options[:city]
          return row[Area::ZIP::CITY]
        elsif options[:state]
          return row[Area::ZIP::STATE]
        else
          return "#{row[Area::ZIP::CITY]}, #{row[Area::ZIP::STATE]}"
        end
      end
    else
      warn "[DEPRECATION] using to_region on an array of integers has been deprecated. Use a string instead."
      return nil
    end
  end

  # Public: Convert a lat/lon pair to a zip code.
  #
  # Examples
  #
  #   [40.71209, -73.95427].to_zip
  #   #=> "11211"
  #
  # Returns a String of converted places.
  def to_zip
    Area.zip_codes.find do |row|
      if row[Area::ZIP::LONGITUTE] && row[Area::ZIP::LATITUTE]
        db_lat_len = row[Area::ZIP::LONGITUTE].split('.').length
        db_lon_len = row[Area::ZIP::LATITUTE].split('.').length
        lat = "%.#{db_lat_len}f" % self[0]
        lon = "%.#{db_lon_len}f" % self[1]
        db_lat = "%.#{db_lat_len}f" % row[Area::ZIP::LONGITUTE].to_f
        db_lon = "%.#{db_lon_len}f" % row[Area::ZIP::LATITUTE].to_f
        if db_lat.to_s == lat.to_s && db_lon.to_s == lon.to_s
          return row[Area::ZIP::ZIPCODE]
        end
      end
    end
  end

  # Public: Convert a lat/lon pair to its GMT offset.
  #
  # Examples
  #
  #   [40.71209, -73.95427].to_gmt_offset
  #   #=> "-5"
  #
  # Returns a String representation of the GMT offset.
  def to_gmt_offset
    row = Area.zip_codes.find {|row| row[Area::ZIP::LONGITUTE] == self[0].to_s && row[Area::ZIP::LATITUTE] == self[1].to_s }
    row[Area::ZIP::GMT_OFFSET] if row
  end


  # Public: Determine if a lat/lon pair observes daylight savings time.
  #
  # Examples
  #
  #   [40.71209, -73.95427].to_dst
  #   #=> "1"
  #
  # Returns a String representation of daylight savings time observance.
  def to_dst
    row = Area.zip_codes.find {|row| row[Area::ZIP::LONGITUTE] == self[0].to_s && row[Area::ZIP::LATITUTE] == self[1].to_s }
    row[Area::ZIP::DAYLIGHT_SAVING] if row
  end

  # Public: Return boolean for daylight savings time observance.
  #
  # Examples
  #
  #   [40.71209, -73.95427].observes_dst?
  #   #=> true
  #
  # Returns a Boolean of the daylight savings time observance.
  def observes_dst?
    to_dst == "1"
  end

end
