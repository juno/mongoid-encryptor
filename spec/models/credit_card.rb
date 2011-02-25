class CreditCard
  include Mongoid::Document
  include Mongoid::Encryptor

  field :number

  validates_format_of :number, :with => /^\A\d{16}\z/

  encrypts :number, :mode => :symmetric, :password => 'secret'
end
