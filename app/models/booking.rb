class Booking < ApplicationRecord
  belongs_to :car
  belongs_to :person
end
