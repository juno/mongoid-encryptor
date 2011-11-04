# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mongoid/encryptor/version"

Gem::Specification.new do |s|
  s.name        = "mongoid-encryptor"
  s.version     = Mongoid::Encryptor::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Junya Ogura"]
  s.email       = ["junyaogura@gmail.com"]
  s.homepage    = "http://github.com/juno/mongoid-encryptor"
  s.summary     = "Encrypt a Mongoid model fields"
  s.description = "mongoid-encryptor encrypts and decrypts one or more fields in a Mongoid model."

  s.rubyforge_project = "mongoid-encryptor"

  s.add_dependency("mongoid", "~> 2")
  s.add_dependency("encrypted_strings", "~> 0.3.3")
  s.add_development_dependency("database_cleaner", "~> 0.6.7")
  s.add_development_dependency("rspec", "~> 2.7.0")

  s.files         = Dir.glob("lib/**/*") + %w(CHANGELOG.md LICENSE README.md)
  s.test_files    = Dir.glob("spec/**/*")
  s.require_paths = ["lib"]
end
