class ShaWithSaltCredential
  include Mongoid::Document
  include Mongoid::Encryptor

  field :email
  field :password

  validates_presence_of :email, :password

  encrypts :password, :mode => :sha, :salt => 'admin'
end
