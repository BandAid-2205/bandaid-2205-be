class VenueArtistsController < ApplicationController
  before_action :set_vars_va_params, only: [:create] #callback action 
  before_action :set_vars_params, only: [:update, :show]

  def create 
    va = VenueArtist.create!(venue_id: @venue.id, artist_id: @artist.id)
    venue_artist_json_response(va) 
  end

  def update  
    @va.update_attributes!(va_params)
    venue_artist_json_response(@va) 
  end

  def show 
    venue_artist_json_response(@va)
  end

  private 
    def va_params
      params.require(:venue_artist).permit(:venue_id, :artist_id, :booking_status)
    end

    def set_vars_va_params
      @venue = Venue.find_by!(user_id: va_params[:venue_id])
      @artist = Artist.find_by!(user_id: va_params[:artist_id])
    end

    def set_vars_params
      @venue = Venue.find_by!(user_id: params[:id])
      @artist = Artist.find_by!(user_id: params[:artist_id])
      @va = VenueArtist.find_by!(venue_id: @venue.id, artist_id: @artist.id)
    end
end