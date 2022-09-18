class ArtistPoro
  attr_reader :id, :name, :bio, :genre, :image_path

  def initialize(data)
    @id = 1 
    @name = data[:name]
    @bio = data[:bio][:summary]
    @genre = data[:tags][:tag].first[:name]
    @image_path = data[:image][2][:"#text"]
  end
end