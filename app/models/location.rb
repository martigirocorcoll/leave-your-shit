class Location < ApplicationRecord
  has_one_attached :photo
  has_many :bookings, dependent: :destroy


  geocoded_by :location_address
  after_validation :geocode, if: :will_save_change_to_location_address?
  belongs_to :user

  validates :name, presence: true, uniqueness: true, length: { minimum: 6 }
  validates :property_type, presence: true
  validates :location_address, presence: true
  validates :description, presence: true, length: { minimum: 20 }
  validates :availability, exclusion: [nil]
  validates :price, presence: true, numericality: true

  # I ended up not using the below, but the method is here if needed
  include PgSearch::Model
  pg_search_scope :search_by_address,
    against: [ :location_address ],
    using: {
      tsearch: { prefix: true }
    }
end
