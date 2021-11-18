class LocationsController < ApplicationController
  def index
    if params[:query].present?
      # @locations = policy_scope(Location).search_by_address(params[:query]).order(created_at: :desc)
      @locations = policy_scope(Location).near(params[:query]).order(created_at: :desc)

    else
      @locations = policy_scope(Location).order(created_at: :desc)
    end

    # @locations = policy_scope(Location).order(created_at: :desc)
    authorize @locations
    #  @locations = Location.all
      @markers = @locations.geocoded.map do |location|
      {
        lat: location.latitude,
        lng: location.longitude,
        info_window: render_to_string(partial: "info_window", locals: { location: location }),
      }
    end
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
  @markers = [{
  lat: @location.latitude,
  lng: @location.longitude,
  info_window: render_to_string(partial: "info_window", locals: { location: location }),
  }]
end

private


  def location_params
    params.require(:location).permit(
      :name,
      :location_address,
      :description,
      :availability,
      :price,
      :property_type,
      :photo
    )
  end
end
