class VenueArtist < ApplicationRecord
  validates_presence_of :venue_id
  validates_presence_of :artist_id
  validates_presence_of :booking_status, inclusion: [0, 1, 2]

  belongs_to :venue
  belongs_to :artist

  enum booking_status: [:pending, :accepted, :rejected]
end
