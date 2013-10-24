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
      row = Area.zip_codes.find {|row| row[4] == self[0].to_s and row[5] == self[1].to_s }
      return nil if !row
      return row[2] if options[:city]
      return row[1] if options[:state]
      return row[2] + ', ' + row[1]
    else
      warn "[DEPRECATION] using to_region on an array of integers has been deprecated. Use a string instead."
      return nil
    end
  end

  # Public: Convert a lat/lon pair to a zip code.
  #
  # Examples
  #
  #   ['40.71', '-73.95'].to_zip
  #   #=> ["10038", "10273", "10278", "10292"]
  #
  # Returns an Array of converted places.
  def to_zip
    if self[0].is_a?(String) and self[1].is_a?(String)
      @zip_codes = Area.zip_codes.find_all { |row|
        if row[4] and row[5]
          db_lat_len = row[4].split('.').length
          db_lon_len = row[5].split('.').length
          lat = "%.#{db_lat_len}f" % self[0]
          lon = "%.#{db_lon_len}f" % self[1]
          db_lat = "%.#{db_lat_len}f" % row[4].to_f
          db_lon = "%.#{db_lon_len}f" % row[5].to_f
          db_lat.to_s == lat.to_s and db_lon.to_s == lon.to_s
        end
      }.map { |a| a.first }
    else
      warn "[DEPRECATION] using to_region on an array of integers has been deprecated. Use a string instead."
      return nil
    end
  end

  # Public: Convert a lat/lon pair to its GMT offset.
  #
  # DEPRECATED!
  #
  # Examples
  #
  #   ["40.71209", "-73.95427"].to_gmt_offset
  #   #=> "-5"
  #
  # Returns a String representation of the GMT offset.
  def to_gmt_offset
    if self[0].is_a?(String) and self[1].is_a?(String)
      row = Area.zip_codes.find {|row| row[3] == self[0].to_s and row[4] == self[1].to_s }
      row[5] if row
    else
      warn "[DEPRECATION] using to_region on an array of integers has been deprecated. Use a string instead."
      return nil
    end
  end


  # Public: Determine if a lat/lon pair observes daylight savings time.
  #
  # DEPRECATED!
  #
  # Examples
  #
  #   ["40.71209", "-73.95427"].to_dst
  #   #=> "1"
  #
  # Returns a String representation of daylight savings time observance.
  def to_dst
    if self[0].is_a?(String) and self[1].is_a?(String)
      row = Area.zip_codes.find {|row| row[3] == self[0].to_s and row[4] == self[1].to_s }
      row[6] if row
    else
      warn "[DEPRECATION] using to_region on an array of integers has been deprecated. Use a string instead."
      return nil
    end

  end

  # Public: Return boolean for daylight savings time observance.
  #
  # Examples
  #
  #   ["40.71209", "-73.95427"].observes_dst?
  #   #=> true
  #
  # Returns a Boolean of the daylight savings time observance.
  def observes_dst?
    to_dst == "1"
  end

end
