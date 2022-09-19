class VenueArtistsController < ApplicationController 
  def create 
    va = VenueArtist.create!(va_params)
    venue_artist_json_response(va) 
  end

  def update 
    va = VenueArtist.find_by!(venue_id: params[:id])
    va.update_attributes!(va_params)
    venue_artist_json_response(va) 
  end

  private 
    def va_params
      params.require(:venue_artists).permit(:venue_id, :artist_id, :booking_status)
    end
end