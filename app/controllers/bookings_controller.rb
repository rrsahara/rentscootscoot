class BookingsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :index]

  def index
    @user = current_user
    @bookings = Booking.where(user: @user)
  end

  def show
    @user = current_user
    @booking = Booking.find(params[:id])
    @review = Review.new
  end

  def create
    @user = current_user
    @scooter = Scooter.find(params[:scooter_id])
    @booking = Booking.new(booking_params)
    @booking.user = @user
    @booking.scooter = @scooter

    if @booking.save
      redirect_to bookings_path
    else
      render :index
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
