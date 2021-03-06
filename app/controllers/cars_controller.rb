class CarsController < ApplicationController
  before_action :find_car, only: %i[show info edit update destroy]

  def index
    @cars = Car.all.order('created_at DESC')
  end

  def show
    @booking = Booking.create
  end

  def info; end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)

    if @car.save
      redirect_to info_car_path(@car)
      flash[:success] = 'Car is added successfully.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @car.update(car_params)
      redirect_to info_car_path(@car)
      flash[:success] = 'Changes have bin saved.'
    else
      render :edit
    end
  end

  def destroy
    @car.destroy
    redirect_to cars_path
  end

  private

  def car_params
    params.require(:car).permit(:brand, :plate, :color, :photo)
  end

  def find_car
    @car = Car.find(params[:id])
  end
end
