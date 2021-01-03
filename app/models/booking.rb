class Booking < ApplicationRecord
  belongs_to :car
  belongs_to :person

  validate :end_date_after_start_date
  # validate :check_date

  # validates :start_date, :end_date, presence: true
  # validate :date_validation
  # def booked_date_range
  #   { from: :start_date, to: :end_date }
  # end

  # # validate :date_available?, on: :create

  # def unavailable_dates
  #   # get an array of [start_date, end_date] then map into Hash object
  #   bookings.where("end_date > ?", DateTime.now).pluck(:start_date, :end_date).map do |range|
  #     { from: range[0], to: range[1] }
  #   end
  # end

  # def can_book_for?(start_date, end_date)
  #   !bookings.exists?(['start_date >= ? AND end_date <= ?', start_date, end_date])
  # end

  # def date_available?
  #   if booking.end_date_after_start_date(start_date, end_date)
  #     return true
  #   else
  #     errors.add(:dates, "Selected dates are not available to book!")
  #     return false
  #   end
  # end


  private

  def date_validation
		errors.add(:start_date, "is not available") unless Booking.where("? >= start_date AND ? <= end_date",
															start_date, start_date).where("? = car_id", car_id).count == 0
		errors.add(:end_date, "is not available") unless Booking.where("? >= start_date AND ? <= end_date",
															end_date, end_date).where("? = car_id", car_id).count == 0
	end

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, 'must be after the start date')
    end
  end
end
