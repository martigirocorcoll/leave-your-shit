class Location < ApplicationRecord
  has_many_attached :photo
  belongs_to :user
  has_many :bookings
  validates :name, presence: true, uniqueness: true, length: { minimum: 6 }
  validates :property_type, presence: true
  validates :location_address, presence: true
  validates :description, presence: true, length: { minimum: 20 }
  validates :availability, exclusion: [nil]
  validates :price, presence: true, numericality: true
end
