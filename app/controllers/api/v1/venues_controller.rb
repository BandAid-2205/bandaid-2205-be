class Api::V1::VenuesController < ApplicationController 
  def create
    binding.pry 
    test = render json: Venue.create!(venue_params)
    binding.pry 
  end

  private 
    def venue_params
      params.require(:venue).permit(:name, :location, :phone, :price, :rating, :user_id, :category => [])
    end
end