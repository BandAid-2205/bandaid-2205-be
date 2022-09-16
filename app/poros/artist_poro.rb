class ArtistPoro
  attr_reader :name, :bio, :genres, :image_path

  def initialize(data)
    @name = data[:name]
    @bio = data[:bio][:summary]
    @genres = get_genres(data[:tags][:tag])
    @image_path = data[:image][2][:"#text"]
  end

  def get_genres(tags)
    tags.map { |tag| tag[:name] }
  end
end