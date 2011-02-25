class Person
  include Mongoid::Document

  field :first_name
  field :last_name

  embeds_one :credit_card

  validates_presence_of :first_name, :last_name
end
