class Credential
  include Mongoid::Document
  include Mongoid::Encryptor

  field :email
  field :password

  validates_presence_of :email, :password
end
