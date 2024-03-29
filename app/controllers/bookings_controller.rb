class BookingsController < ApplicationController

 def new
   @booking = Booking.new
   @location = Location.find(params[:location_id])
   authorize @booking
   authorize @location
 end

 def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    @location = Location.find(params[:location_id])
    @booking.location = @location
    authorize @booking
  if @booking.save
    redirect_to booking_path(@booking)
  else
    render "locations/show"
  end
 end

 def show
   @booking = Booking.find(params[:id])
   authorize @booking
 end

 def update
  @booking = Booking.find(params[:id])
  authorize @booking
  if @booking.update(status: params[:status])
    redirect_to dashboard_path
  end
  end

   private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :status)
  end
end
