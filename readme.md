[![Build Status](https://secure.travis-ci.org/jgv/area.png)](http://travis-ci.org/jgv/area)
# Area

Hi. This gem allows you to perform the following conversions:

* An area code to a region (state)
* A state to an area code
* A place to a zip code
* A zip code to a place (control granularity with city and state options)
* A zipcode to a lat/lon
* A zipcode to just a lat
* A zipcode to just a lon
* A zipcode to its GMT offset
* A state to its GMT offset
* A lat/lon pair to a region
* A lat/lon pair to its GMT offset
* A lat/lon pair to its zip code

Area uses public domain data and does not rely on any external services (the internets). Usage is meant to be more lightweight than the Geocoder gem.

## Installation

In your gemfile: `gem 'area'`

## Usage

#### Convert an area code to a state/region
``` ruby
646.to_region #=> NY
```

#### Convert a state to an area code
```` ruby
"AK".to_area #=> ["907"]
"CT".to_area #=> ["203", "860"]
```

#### Convert a place to a zip code
```` ruby
"long island city, ny".to_zip #=> ["11101", "11109", "11120"]
"hastings on hudson".to_zip #=> ["10706"]
```

#### Convert a zip code to a place
```` ruby
"11211".to_region #=> "Brooklyn, NY"
"11211".to_region(:city => true) #=> "Brooklyn"
"11211".to_region(:state => true) #=> "NY"
```

#### Convert a zip code to a lat/lon
```` ruby
"11211".to_latlon #=> "40.71209, -73.95427"
```

#### Convert a zip code to a lat
```` ruby
"11211".to_lat #=> "40.71209"
```

#### Convert a zip code to a lon
```` ruby
"11211".to_lon #=> "-73.95427"
```

#### Get the GMT offset of a zipcode
```` ruby
"11211".to_gmt_offset #=> "-5"
```

#### Get the GMT offset of a state
```` ruby
"NY".to_gmt_offset #=> "-5" # by state
```

#### Determine daylight savings time observance of a zipcode
```` ruby
"11211".observes_dst? #=> true
```

#### Determine daylight savings time observance of a state
```` ruby
"NY".observes_dst? #=> true # by state
```

#### Convert a lat/lon pair to a zipcode
```` ruby
[40.71209, -73.95427].to_zip #=> "11211"
```

#### Convert a lat/lon pair to a region
```` ruby
[40.71209, -73.95427].to_region #=> "Brooklyn, NY"
```

#### Get the GMT offset for a lat/lon pair
```` ruby
[40.71209, -73.95427].to_gmt_offset #=> "-5"
```

#### Determine daylight savings time observance for a lat/lon pair
```` ruby
[40.71209, -73.95427].observes_dst? #=> true
```

## Testing and Contributing and Stuff

Contributions are more than welcome. I'm [testing](http://travis-ci.org/jgv/area) with minitest. This gem supports:

* Ruby 1.8.7
* Ruby 1.9.2
* Ruby 1.9.3
* JRuby 1.8
* JRuby 1.9
* Rubinius 1.8
* Rubinius 1.9

## Copyright

Copyright (c) 2012 Jonathan Vingiano. See [LICENSE](https://github.com/jgv/area/blob/master/MIT-LICENSE) for details.
