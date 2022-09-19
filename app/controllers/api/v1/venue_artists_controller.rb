class Api::V1::VenueArtistsController < ApplicationController 
  def create 
    va = VenueArtist.create!(va_params)
    venue_artist_json_response(va)
  end

  private 
    def va_params
      params.require(:venue_artists).permit(:venue_id, :artist_id)
    end
end