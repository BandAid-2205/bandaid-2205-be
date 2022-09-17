class Api::V1::VenuesController < ApplicationController 
  def create
    binding.pry 
    venue = Venue.create!(venue_params)
    test = render json: venue 
    binding.pry 
  end

  private 
    def venue_params
      params.require(:venue).permit(:name, :location, :phone, :price, :rating, :user_id, :category => [])
    end
end