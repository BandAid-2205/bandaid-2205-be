class Api::V1::ArtistsController < ApplicationController
  def create
    artist = Artist.new(artist_params)
    if artist.save
      render json: ArtistSerializer.new(artist), status: 201
    else
      render status: 422
    end
  end

  def update
    artist = Artist.find(params[:id])
    if artist.update(artist_params)
      render json: ArtistSerializer.new(artist)
    else
      render status: 404
    end
  end

  def destroy
    if Artist.exists?(params[:id])
      Artist.destroy(params[:id])
    else
      render status: 404
    end
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
