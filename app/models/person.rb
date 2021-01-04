class Person < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :cars, through: :bookings

  validates :firstname, :lastname, :birthdate, presence: true

  def fullname
    "#{firstname} #{lastname}"
  end
end
