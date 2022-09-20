class ArtistSerializer
  include JSONAPI::Serializer
  attributes :name, :location, :bio, :genre, :image_path, :user_id

  has_many :venues, if: Proc.new { |record| record.venues.any? }
  has_many :venue_artists

  attribute :venues do |object|
    object.venues.as_json
  end

  attribute :venue_artists do |object|
    object.venue_artists.as_json
  end
end
