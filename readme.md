[![Build Status](https://secure.travis-ci.org/jgv/area.png)](http://travis-ci.org/jgv/area)

# Area

Hi. This gem allows you to convert a region in the United States to an area code and vice versa. Area uses public data and does not rely on any external services or have any dependencies. 

## Usage

In your gemfile: `gem 'area'`

In your code: 

``` ruby
646.to_region #=> NY
"AK".to_area #=> ["907"]
"CT".to_area #=> ["203", "860"]
```

### Testing and Contributing

Contributions are more than welcome. I'm testing with minitest.
