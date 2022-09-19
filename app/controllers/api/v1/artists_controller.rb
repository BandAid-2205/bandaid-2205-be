class Api::V1::ArtistsController < ApplicationController
  def show
    artist = Artist.find_by!(user_id: params[:id])
    artist_json_response(artist)
  end

  def create
    artist = Artist.create!(artist_params)
    artist_json_response(artist)
  end

  def update
    artist = Artist.find_by!(user_id: params[:id])
    artist.update_attributes!(artist_params)
    artist_json_response(artist)
  end

  def destroy
    artist = Artist.find_by!(user_id: params[:id])
    Artist.destroy(artist.id)
  end

  private
  def artist_params
    params.require(:artist).permit(
                              :name,
                              :location,
                              :bio,
                              :genre,
                              :image_path,
                              :user_id)
  end
end
