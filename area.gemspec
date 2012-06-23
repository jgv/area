# -*- encoding: utf-8 -*-
require File.expand_path('../lib/area/version', __FILE__)

Gem::Specification.new do |s|
  s.name = "area"
  s.version = Area::VERSION
  s.authors     = ["Jonathan Vingiano"]
  s.email       = ["jgv@jonathanvingiano.com"]
  s.homepage    = "http://github.com/jgv/area"
  
  s.rubyforge_project = "area"

  s.summary = "Convert a region to area code and vice versa."
  s.description = "Area allows you to convert a region in the United States to an area code and vice versa. Area uses public data and does not rely on any external services or have any dependencies."
  s.files = Dir["data/*"] + Dir["lib/*"] + ["MIT-LICENSE", "Rakefile", "readme.md"] 
  
  s.require_paths = ['lib']
  s.add_development_dependency 'rake'
  s.add_development_dependency 'minitest'
end
