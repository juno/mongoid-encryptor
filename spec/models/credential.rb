class Credential
  include Mongoid::Document
  include Mongoid::Encryptor

  field :email
  field :password

  validates_presence_of :email, :password
  validates_format_of :email, :with => /^\A[^@]+@[^@]+\z/
end
