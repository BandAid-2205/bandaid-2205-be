class Venue < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :location
  validates_presence_of :phone
  validates :price, inclusion: ['$', '$$', '$$$', '$$$$']
  validates_presence_of :category, allow_nil: true
  validates_presence_of :rating, allow_nil: true
  validates_numericality_of :rating, allow_nil: true
  validates_presence_of :user_id

  has_many :events
  has_many :venue_artists, dependent: :destroy
  has_many :artists, through: :venue_artists
end
