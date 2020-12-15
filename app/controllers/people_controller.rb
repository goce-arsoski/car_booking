class PeopleController < ApplicationController
  before_action :find_person, only: %i[show edit update destroy]

  def index
    @people = Person.all.order('created_at DESC')
  end

  def show; end

  def new
    @person = Person.new
  end

  def create
    @person = Person.new(person_params)

    if @person.save
      redirect_to @person
    else
      render :new
    end
  end

  def edit; end

  def update
    if @person.update(person_params)
      redirect_to @person
    else
      render :edit
    end
  end

  def destroy
    @person.destroy
    redirect_to people_path
  end

  private

  def person_params
    params.require(:person).permit(:firstname, :lastname, :birthdate)
  end

  def find_person
    @person = Person.find(params[:id])
  end
end
