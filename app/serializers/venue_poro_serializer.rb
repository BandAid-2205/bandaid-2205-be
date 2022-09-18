class VenuePoroSerializer
  include JSONAPI::Serializer
  attributes :name, :rating, :phone, :price, :location, :category
end