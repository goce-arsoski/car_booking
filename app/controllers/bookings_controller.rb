class BookingsController < ApplicationController
  before_action :find_booking, only: %i[show edit update destroy]

  def index
    @bookings = Booking.all.order('created_at DESC')
  end

  def show; end

  def new
    @booking = Booking.new
  end

  def create
    @booking = Booking.new(booking_params)

    if @booking.save
      redirect_to @booking
    else
      render :new
    end
  end

  def edit; end

  def update
    if @booking.update(booking_params)
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
    goce
  end

  private

  def booking_params
    params.require(:booking)
          .permit(:status, :start_date, :end_date, :car_id, :person_id)
  end

  def find_booking
    @booking = Booking.find(params[:id])
  end
end
