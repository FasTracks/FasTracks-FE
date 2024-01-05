class PlaylistController < ApplicationController
  def generate
    access_token = params[:tkn]

    if !access_token.nil?
      flash[:notice] = "Spotify authorization successful."
      genre_response = SpotifyApiService.get_genres(access_token)
      @genres = genre_response[:data][:genres]
    else
      flash[:error] = "Spotify authorization failed. #{params[:error]}"
      redirect_to root_path
    end
  end

  def show
    # used to display the playlist to the user
  end

  def create
    # make service call to backend to create playlist; pass params
  end
end
