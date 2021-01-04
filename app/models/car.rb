class Car < ApplicationRecord
  has_one_attached :photo
  has_many :bookings, dependent: :destroy
  has_many :people, through: :bookings

  validates :brand, :plate, :color, presence: true

  validates :photo, presence: true,
                    blob: {
                      content_type: ['image/jpg', 'image/jpeg', 'image/png'],
                      size_range: 0..3.megabytes
                    }
end
