class Api::V1::Lastfm::ArtistInfoController < ApplicationController 
  def find_artist
    binding.pry 
    data = ArtistSearchFacade.artist_search(params[:query])
  end
end