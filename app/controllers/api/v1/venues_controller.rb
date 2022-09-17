class Api::V1::VenuesController < ApplicationController 
  def create
    render json: Venue.create(venue_params)
  end

  private 
    def venue_params
      params.require(:venue).permit(:name, :location, :phone, :price, :category, :rating, :user_id)
    end
end