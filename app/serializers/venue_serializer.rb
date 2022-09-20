class VenueSerializer
  include JSONAPI::Serializer
  attributes :name, :location, :phone, :price, :category, :rating, :user_id

  has_many :artists, if: Proc.new { |record| record.artists.any? }
  has_many :venue_artists, if: Proc.new { |record| record.venue_artists.any? }

  attribute :artists do |object|
    object.artists.as_json
  end

  attribute :venue_artists do |object|
    object.venue_artists.as_json
  end
end
