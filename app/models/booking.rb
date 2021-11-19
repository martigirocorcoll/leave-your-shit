class Booking < ApplicationRecord
  before_create :set_agreed_price
  belongs_to :user
  belongs_to :location
  validates :start_date, presence: true, allow_blank: false
  validates :end_date, presence: true, allow_blank: false
  enum status: {
    pending: 0,
    accepted: 1,
    declined: 2
  }
  def set_agreed_price
    self.agreed_price = (self.end_date - self.start_date).to_i * self.location.price
  end
end
