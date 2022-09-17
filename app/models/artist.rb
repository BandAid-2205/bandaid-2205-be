class Artist < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :location
  validates_presence_of :bio
  validates_presence_of :genres
  validates_presence_of :image_path, allow_nil: true
  validates_presence_of :user_id

  has_many :artist_events, dependent: :destroy
  has_many :events, through: :artist_events
end
