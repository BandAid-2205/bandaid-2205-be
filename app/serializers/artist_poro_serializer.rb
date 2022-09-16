class ArtistPoroSerializer
  include JSONAPI::Serializer
  attributes :name, :bio, :genres, :image_path
end
