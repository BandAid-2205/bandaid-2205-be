class ArtistSerializer
  include JSONAPI::Serializer
  attributes :name, :location, :bio, :genre, :image_path, :user_id
end
