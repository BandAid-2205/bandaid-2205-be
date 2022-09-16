class Artist
  def initialize(data)
    @name = data[:name]
    @bio = data[:bio][:summary]
    @genres = get_genres(data[:tags][:tag])
  end

  def get_genres(tags)
    tags.map { |tag| tag[:name] }
  end
end