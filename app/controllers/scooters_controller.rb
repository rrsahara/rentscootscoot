class ScootersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :user, only: [:index, :show, :new, :create]

  def index
    @scooters = params[:search] ? Scooter.where('lower(name) LIKE ?', "%#{params[:search].downcase}%") : Scooter.all
  end

  def show
    @scooter = Scooter.find(params[:id])
    @reviews = @scooter.reviews
    @booking = Booking.new
    @review = Review.new

  end

  def new
    @scooter = Scooter.new
  end

  def create
    @scooter = Scooter.new(scooter_params)
    @scooter.user = @user
    if @scooter.save
      redirect_to scooter_path(@scooter)
    else
      render :new
    end
  end

  private

  def user
    @user = current_user
  end

  def scooter_params
    params.require(:scooter).permit(:description, :price, :status, :location, :photo, :name)
  end
end
