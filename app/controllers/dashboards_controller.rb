class DashboardsController < ApplicationController

  def show
    @bookings = current_user.bookings
    @requests = current_user.requests.pending
  end


end
