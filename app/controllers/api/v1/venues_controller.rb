class Api::V1::VenuesController < ApplicationController
  before_action :set_venue, only: [:show, :update, :destroy] #callback action 

  def index
    render json: VenueSerializer.new(Venue.all)
  end

  def create
    venue = Venue.create!(venue_params)
    venue_json_response(venue)
  end

  def show
    venue_json_response(@venue)
  end

  def update
    @venue.update_attributes!(venue_params)
    venue_json_response(@venue)
  end

  def destroy
    render json: Venue.destroy(@venue.id)
    head :no_content
  end

  private
    def set_venue 
      @venue = Venue.find_by!(user_id: params[:id])
    end

    def venue_params
      params.require(:venue).permit(:name, :location, :phone, :price, :rating, :category, :user_id)
    end
end
