class Event < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :date
  validates_presence_of :start_time
  validates_presence_of :end_time
  validates_presence_of :booking_status
  validates_presence_of :venue_id

  has_many :artist_events, dependent: :destroy
  has_many :artists, through: :artist_events
  belongs_to :venue

  enum booking_status: { 'open' => 0, 'pending' => 1, 'booked' => 2, 'closed' => 3 }
end
