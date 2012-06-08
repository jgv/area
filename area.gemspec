# -*- encoding: utf-8 -*-
require File.expand_path('../lib/area/version', __FILE__)

Gem::Specification.new do |s|
  s.name = "area"
  s.version = Area::VERSION
  s.authors     = ["Jonathan Vingiano"]
  s.email       = ["jgv@jonathanvingiano.com"]
  s.homepage    = "http://github.com/jgv/area"
  
  s.rubyforge_project = "area"

  s.summary = "Look up a region by area code."
  s.description = "This gem lets you find a region by an area code."
  s.files = Dir["data/*"] + Dir["lib/*"] + ["MIT-LICENSE", "Rakefile", "readme.md"] 
  
  s.require_paths = ['lib']
end
