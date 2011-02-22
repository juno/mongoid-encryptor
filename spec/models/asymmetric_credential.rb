class AsymmetricCredential
  include Mongoid::Document
  include Mongoid::Encryptor

  field :email
  field :password

  validates_presence_of :email, :password

  encrypts :password, :mode => :asymmetric,
    :private_key_file => File.dirname(__FILE__) + '/../keys/private',
    :public_key_file => File.dirname(__FILE__) + '/../keys/public'
end
