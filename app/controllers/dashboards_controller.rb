class DashboardsController < ApplicationController

  def show
    @bookings = current_user.bookings
    @requests = current_user.requests.pending
    @locations = current_user.locations
  end


end
