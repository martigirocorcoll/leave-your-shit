class LocationsController < ApplicationController

  def index
    @locations = Location.all
  end

def new
  @location = Location.new
end

def create
@location = Location.new(location_params)
    if @location.save
      redirect_to locations_path
    else
      render :new
    end
end

def show
  @location = Location.find(params[:id])
  @booking = Booking.new
end

private

  def location_params
    params.require(:location).permit(:name, :location_address, :description, :availability, :price, :property_type)
  end

end
