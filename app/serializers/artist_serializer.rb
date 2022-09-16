class ArtistSerializer
  include JSONAPI::Serializer
  attributes :name, :location, :bio, :genres, :image_path, :user_id
end
