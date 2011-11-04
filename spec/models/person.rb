class Person
  include Mongoid::Document

  field :first_name
  field :last_name

  embeds_one :credential
  embeds_many :credit_cards

  validates_presence_of :first_name, :last_name
end
