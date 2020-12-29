class Person < ApplicationRecord
  has_many :bookings
  has_many :cars, through: :bookings

  def fullname
    "#{firstname} #{lastname}"
  end
end
