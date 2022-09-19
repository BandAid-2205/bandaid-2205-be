class VenueArtistSerializer 
  include JSONAPI::Serializer 
  attributes :venue_id, :artist_id, :booking_status

  belongs_to :artist 
end