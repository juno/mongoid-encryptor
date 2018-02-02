**THIS PROJECT IS DEPRECATED AND NO LONGER MAINTAIN. (Feb, 2018)**

mongoid-encryptor
=================

[![Build Status](http://travis-ci.org/juno/mongoid-encryptor.png)](http://travis-ci.org/juno/appraiser)

mongoid-encryptor encrypts and decrypts one or more fields in a Mongoid model.

Prerequisites
-------------

* ruby 1.9.2 or 1.9.3
* mongoid 2.0 or later
* activesupport 3.0 or later


Install
-------

Put this line in your Gemfile:

    gem 'mongoid-encryptor', :require => 'mongoid/encryptor'

Then bundle:

    $ bundle


Quick Start
-----------

Set up SHA encrypted field in models like this:

    class Credential
      include Mongoid::Document
      include Mongoid::Encryptor
      field :password
      encrypts :password
    end
    
    >> c = Credential.new
    => #<Credential _id: 4d6383aeb2de3cbea1000001, password: nil>
    >> c.password = 'this is a secret'
    => "this is a secret"
    >> c.password.encrypted?
    => false
    >> c.save
    => true
    
    >> c.password
    => "70a202166f0a78defe464d810f30b50b767cb89a"
    >> c.password.encrypted?
    => true
    >> c.password.cipher.salt
    => "salt"
    >> c.password == 'this is a secret'
    => true


Symmetric encryption
--------------------

Set up Symmetric encrypted field in models like this:

    class Credential
      include Mongoid::Document
      include Mongoid::Encryptor
      field :password
      encrypts :password, :mode => :symmetric, :password => 'key'
    end
    
    >> c = Credential.new
    => #<Credential _id: 4d638b6db2de3cc2ca000001, password: nil>
    >> c.password = 'this is a secret'
    => "this is a secret"
    >> c.password.encrypted?
    => false
    >> c.save
    => true
    
    >> c.password
    => "y3HnNrU0HviAl3aw2sWH1KttBLsCLYP1\n"
    >> c.password.encrypted?
    => true
    >> c.password.cipher
    => #<EncryptedStrings::SymmetricCipher:0x000001016b1c08 @algorithm="DES-EDE3-CBC", @password="key">
    >> c.password.cipher.password
    => "key"
    >> c.password == 'this is a secret'
    => true


Asymmetric encryption
---------------------

Set up Asymmetric encrypted field in models like this:

    class Credential
      include Mongoid::Document
      include Mongoid::Encryptor
      field :password
      encrypts :password, :mode => :asymmetric,
        :private_key_file => '/path/to/private_key',
        :public_key_file => '/path/to/public_key'
    end
    
    >> c = Credential.new
    => #<Credential _id: 4d638ceab2de3cc3c1000001, password: nil>
    >> c.password = 'this is a secret'
    => "this is a secret"
    >> c.password.encrypted?
    => false
    >> c.save
    => true
    
    >> c.password
    => "ha/2EacZTmvAIHOSjFEshM+9UHUItB/wGKJ5ftClQDllA9SOBJJazTlsMS9m\nPd5W3goZbY9V2dDdNo4NgQ0e8VsG0dpcvOIrua/ye+jX3e+0ocevcnOH9PL9\n8C5P8caOD/sKlKLTI0Dr1v/6d/f0Q4UuPQyTh3d4aEWyagypWyQ=\n"
    >> c.password.encrypted?
    => true
    >> c.password == 'this is a secret'
    => true

You can generate keypair like this:

    $ openssl genrsa -des3 -out private 1024  # generate private key
    $ openssl rsa -in private -pubout -out public  # generate public key
    $ mv private private.bak
    $ openssl rsa -in private.bak -out private  # remove passphrase from private key
    $ ls -l
    -rw-r--r--   1 juno  staff   887  2 22 19:20 private
    -rw-r--r--   1 juno  staff   963  2 22 19:19 private.bak
    -rw-r--r--   1 juno  staff   272  2 22 19:19 public


Questions, Feedback
-------------------

[github/juno](http://github.com/juno/) or [@junya](http://twitter.com/junya).


References
----------

*  [pluginaweek/encrypted_strings](https://github.com/pluginaweek/encrypted_strings)
*  [pluginaweek/encrypted_attributes](https://github.com/pluginaweek/encrypted_attributes)


Copyright
---------

(c) 2011 Junya Ogura. See LICENSE.txt for further details.
