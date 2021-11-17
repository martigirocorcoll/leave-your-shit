class Location < ApplicationRecord
  has_one_attached :photo
  has_many :bookings
  geocoded_by :location_address
  after_validation :geocode, if: :will_save_change_to_location_address?
  #belongs_to :user


  validates :name, presence: true, uniqueness: true, length: { minimum: 6 }
  validates :property_type, presence: true
  validates :location_address, presence: true
  validates :description, presence: true, length: { minimum: 20 }
  validates :availability, exclusion: [nil]
  validates :price, presence: true, numericality: true
end
