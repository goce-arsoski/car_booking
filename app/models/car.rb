class Car < ApplicationRecord
  has_one_attached :photo
  has_many :bookings
  has_many :people, through: :bookings
end
