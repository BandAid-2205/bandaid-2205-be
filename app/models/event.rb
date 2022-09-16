class Event < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :date
  validates_presence_of :start_time
  validates_presence_of :end_time
  validates_presence_of :booking_status
  validates_presence_of :venue_id

  has_many :artist_events
  has_many :artists, through: :artist_events
  belongs_to :venue
end
