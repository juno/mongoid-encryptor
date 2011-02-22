class SymmetricCredential
  include Mongoid::Document
  include Mongoid::Encryptor

  field :email
  field :password

  validates_presence_of :email, :password

  encrypts :password, :mode => :symmetric, :password => 'key'
end
