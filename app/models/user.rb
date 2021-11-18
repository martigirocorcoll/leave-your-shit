class User < ApplicationRecord
  has_many :bookings
  has_many :locations
  has_many :requests, through: :locations, source: :bookings
  has_one_attached :photo
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
