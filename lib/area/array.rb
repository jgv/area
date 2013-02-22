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
    if self[0].is_a?(String) and self[1].is_a?(String)
      if row = Area.zip_codes.find {|row| row[3] == self[0].to_s and row[4] == self[1].to_s }
        if options[:city]
          return row[1]
        elsif options[:state]
          return row[2]
        else
          return row[1] + ', ' + row[2]
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
    row = Area.zip_codes.find {|row| row[3] == self[0].to_s and row[4] == self[1].to_s }
    row[5] if row
  end

end
