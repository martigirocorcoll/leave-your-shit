class Booking < ApplicationRecord
  before_create :set_agreed_price
  belongs_to :user
  belongs_to :location
  enum status: {
    pending: 0,
    accepted: 1,
    declined: 2
  }
  def set_agreed_price
    self.agreed_price = (self.end_date - self.start_date).to_i * self.location.price
  end
end
