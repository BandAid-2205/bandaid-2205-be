class Artist < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :location
  validates_presence_of :bio, allow_nil: true
  validates_presence_of :genre
  validates_presence_of :image_path, allow_nil: true
  validates_presence_of :user_id

  has_many :venue_artists, dependent: :destroy
  has_many :venues, through: :venue_artists
end
