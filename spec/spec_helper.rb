require 'rubygems'
require 'bundler/setup'

require 'database_cleaner'
require 'mongoid'
require 'rspec'

Mongoid.configure do |config|
  name = 'mongoid_encryptor_test'
  config.master = Mongo::Connection.new.db(name)
end

require File.expand_path("../../lib/mongoid/encryptor", __FILE__)

Dir["#{File.dirname(__FILE__)}/models/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.before(:all) { DatabaseCleaner.strategy = :truncation }
  config.before(:each) { DatabaseCleaner.clean }
end
