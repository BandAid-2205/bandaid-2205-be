class Api::V1::VenuesController < ApplicationController 
  def create
    venue = Venue.create!(venue_params)
    venue_json_response(venue)
  end

  private 
    def venue_params
      params.require(:venue).permit(:name, :location, :phone, :price, :rating, :category, :user_id)
    end
end