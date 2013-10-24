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

## Data Sources

As of version 1.0.0 the data sources for Area has changed for the sake of accuracy.

The postal code data is from [GreatData](http://greatdata.com) which uses Census ZCTA records as a starting point and supplimented with USPS Zip Codes. The data is updated regularly. The latitude and longitude of each zip is determined with an approximate 6 mile margin of accuracy.

The area code data is from [Neustar](http://www.nanpa.com) and adheres to the [North American Numbering Plan](http://en.wikipedia.org/wiki/North_American_Numbering_Plan) which serves [20 North American countries](http://en.wikipedia.org/wiki/North_American_Numbering_Plan#NANP_countries_and_territories).

## Testing and Contributing and Stuff

Contributions are more than welcome. I'm [testing](http://travis-ci.org/jgv/area) with minitest. This gem supports:

* Ruby 1.8.7
* Ruby 1.9.2
* Ruby 1.9.3
* Ruby 2.0.0
* JRuby 1.8
* JRuby 1.9
* Rubinius 1.8
* Rubinius 1.9

## Copyright

Copyright (c) 2013 Jonathan Vingiano. See [LICENSE](https://github.com/jgv/area/blob/master/MIT-LICENSE) for details.
