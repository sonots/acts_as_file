#!/usr/bin/env gem build
# encoding: utf-8

Gem::Specification.new do |s|
  s.name          = "acts_as_file"
  s.authors       = ["Naotoshi Seo"]
  s.email         = ["sonots@gmail.com"]
  s.homepage      = "https://github.com/sonots/acts_as_file"
  s.summary       = "Make your field act as a file"
  s.description   = "Make your field act as a file. Save the content to a file, and load the content from a file."
  s.version       = '0.0.2'
  s.date          = Time.now.strftime("%Y-%m-%d")

  s.extra_rdoc_files = Dir["*.rdoc"]
  s.files         = `git ls-files`.split($\)
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.executables   = s.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.rdoc_options  = ["--charset=UTF-8"]

  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'pry-nav'
end
