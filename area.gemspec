# -*- encoding: utf-8 -*-
require File.expand_path('../lib/area/version', __FILE__)

Gem::Specification.new do |s|
  s.name = "area"
  s.version = Area::VERSION
  s.author = "Jonathan Vingiano"
  s.email = "jgv@jonathanvingiano.com"
  s.homepage = "http://github.com/jgv/area"  
  s.rubyforge_project = "area"
  s.summary = "Convert a region to area code and vice versa."
  s.description = "Area allows you to perform a variety of conversions between places in the United States and area codes or zip codes."
  s.files         = `git ls-files`.split("\n")
  s.require_paths = ['lib']

  s.add_dependency 'fastercsv', '~> 1.5'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'minitest'
end
