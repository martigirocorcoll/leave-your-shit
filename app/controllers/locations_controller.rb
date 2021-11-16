class LocationsController < ApplicationController

  def index
  @locations = policy_scope(Location).order(created_at: :desc)
  authorize @locations
  end

def new
  @location = Location.new
  authorize @location
end

def create
@location = Location.new(location_params)
@location.user_id = current_user.id
authorize @location
    if @location.save
      redirect_to locations_path
    else
      render :new
    end
end

def destroy
  @location = Location.find(params[:id])
  authorize @location
   if @location.destroy
      redirect_to locations_path
  end
end

def show
  @location = Location.find(params[:id])
  @booking = Booking.new
  authorize @location
end

private

  def location_params
    params.require(:location).permit(:name, :location_address, :description, :availability, :price, :property_type, photo: [])
  end

end
