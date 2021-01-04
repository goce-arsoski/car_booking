class BookingsController < ApplicationController
  before_action :find_booking, only: %i[show edit update destroy]

  def index
    @bookings = Booking.all.order('start_date ASC')
  end

  def show; end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)

    if check_date && @booking.save
      redirect_to @booking
      flash[:success] = 'The car is booked successfully.'
    else
      redirect_to car_path(@booking.car)
      flash[:error] = 'Please check available booking dates for this car!'
    end
  end

  def edit; end

  def update
    if update_date && @booking.update(booking_params)
      redirect_to @booking
      flash[:success] = 'Changes have bin saved.'
    else
      render :edit
      flash.now[:error] = 'Please check available booking dates!'
    end
  end

  def destroy
    @booking.destroy
    redirect_to bookings_path
  end

  def fullname
    "#{firstname} #{lastname}"
  end

  private

  def booking_params
    params.require(:booking)
          .permit(:status, :start_date, :end_date, :car_id, :person_id)
  end

  def find_booking
    @booking = Booking.find(params[:id])
  end

  def check_date
    @unavailable = false
    return @unavailable if @booking.start_date.nil? || @booking.end_date.nil?

    bookings = Booking.where(car_id: @booking[:car_id])
    bookings.each do |booking|
      @unavailable = @booking.start_date.between?(
                       booking.start_date, booking.end_date
                     ) ||
                     @booking.end_date.between?(
                       booking.start_date, booking.end_date
                     )
      break if @unavailable == true
    end
    !@unavailable
  end

  def update_date
    @unavailable = false
    return @unavailable if booking_params[:start_date].nil? || booking_params[:end_date].nil?

    bookings = Booking.where(car_id: @booking[:car_id])
    bookings.each do |booking|
      next if booking.id == @booking.id

      @unavailable = booking_params[:start_date].to_date.between?(
                       booking.start_date, booking.end_date
                     ) ||
                     booking_params[:end_date].to_date.between?(
                       booking.start_date, booking.end_date
                     )
      break if @unavailable == true
    end
    !@unavailable
  end
end
