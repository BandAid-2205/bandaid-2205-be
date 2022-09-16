class Api::V1::Lastfm::ArtistInfoController < ApplicationController 
  def find_artist
    data = ArtistSearchFacade.artist_search(params[:query])
    render json: ArtistPoroSerializer.new(data)
  end
end