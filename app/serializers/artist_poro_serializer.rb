class ArtistPoroSerializer
  include JSONAPI::Serializer
  attributes :name, :bio, :genre, :image_path
end
