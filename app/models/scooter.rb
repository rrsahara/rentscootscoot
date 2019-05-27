class Scooter < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :reviews, through: :bookings

  validates :description, presence: true
  validates :status, presence: true
  validates :location, presence: true
end
