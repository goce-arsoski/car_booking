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
    else
      redirect_to car_path(@booking.car)
    end
  end

  def edit; end

  def update
    if update_date && @booking.update(booking_params)
      redirect_to @booking
    else
      render :edit
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
    bookings = Booking.where(car_id: @booking[:car_id]) #== booking_params[:car_id])
    bookings.each do |booking|
      @unavailable = false
      @unavailable = @booking.end_date.between?(
                       booking.start_date, booking.end_date
                     ) ||
                     @booking.start_date.between?(
                       booking.start_date, booking.end_date
                     )
      # flash[:alert] =
      break if @unavailable == true
    end
    !@unavailable
  end

  def update_date
    bookings = Booking.where(car_id: @booking[:car_id])
    bookings.each do |booking|
      next if booking.id == @booking.id

      @unavailable = false
      @unavailable = booking_params[:end_date].to_date.between?(
                       booking.start_date, booking.end_date
                     ) ||
                     booking_params[:start_date].to_date.between?(
                       booking.start_date, booking.end_date
                     )
        # flash[:alert] =
      break if @unavailable == true
      # puts @unavailable
      # return false
    end
    !@unavailable
  end
end
