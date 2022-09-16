class VenueSerializer
  include JSONAPI::Serializer
  attributes :name, :location, :phone, :price, :category, :rating, :user_id
end
