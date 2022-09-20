class VenueArtistsController < ApplicationController
  before_action :set_venue_and_artist, only: [:create] #callback action 

  def create 
    va = VenueArtist.create!(venue_id: @venue.id, artist_id: @artist.id)
    venue_artist_json_response(va) 
  end

  def update 
    va = VenueArtist.find_by!(venue_id: params[:id], artist_id: params[:artist_id])
    va.update_attributes!(va_params)
    venue_artist_json_response(va) 
  end

  def show 
    va = VenueArtist.find_by!(venue_id: params[:id], artist_id: params[:artist_id])
    venue_artist_json_response(va)
  end

  private 
    def va_params
      params.require(:venue_artist).permit(:venue_id, :artist_id, :booking_status)
    end

    def set_venue_and_artist
      @venue = Venue.find_by!(user_id: va_params[:venue_id])
      @artist = Artist.find_by!(user_id: va_params[:artist_id])
    end
end