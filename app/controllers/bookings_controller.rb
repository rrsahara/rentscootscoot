class BookingsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :index, :edit, :update]

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

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
  end
    
  def edit
    @user = current_user
    @booking = Booking.find(params[:id])
  end

  def update
    @booking = Booking.find(params[:id])
    @booking.update(booking_params)

    flash[:notice] = 'Booking successfully updated'
    redirect_to bookings_path
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
