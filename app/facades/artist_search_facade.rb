class ArtistSearchFacade
  def self.artist_search(artist_name)
    json = ArtistService.search_artist(artist_name)

    ArtistPoro.new(json[:artist])
  end
end