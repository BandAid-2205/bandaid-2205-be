class VenueArtist < ApplicationRecord
  validates_presence_of :venue_id
  validates_presence_of :artist_id
  validates_presence_of :booking_status

  belongs_to :venue
  belongs_to :artist

  enum booking_status: { 'pending' => 0, 'accepted' => 1, 'rejected' => 2 }
end
