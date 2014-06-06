require 'rubygems'
require 'rspec'
require 'rspec/its'
require 'pry'
$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')

if ENV['TRAVIS']
  require 'coveralls'
  Coveralls.wear!
end
