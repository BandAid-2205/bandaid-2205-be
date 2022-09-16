class Api::V1::Lastfm::ArtistInfoController < ApplicationController 
  def find_artist
    data = ArtistSearchFacade.artist_search(params[:query])
    if data.class == ArtistPoro
      json_response(data) 
    else 
      error_handle(data) 
    end
  end

  private 
    def json_response(object, status = :ok)
      render json: object, status: status
    end

    def error_handle(object)
      # {:error=>6, :message=>"The artist you supplied could not be found", :links=>[]}
      json_response( { message: object[:message]}, :not_found)
    end
end