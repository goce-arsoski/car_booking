class Booking < ApplicationRecord
  # has_many :cars
  # has_many :people

  belongs_to :car
  belongs_to :person
end
