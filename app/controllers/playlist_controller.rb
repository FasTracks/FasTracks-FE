class PlaylistController < ApplicationController
  def generate
    access_token = params[:tkn]
    if !access_token.nil?
      flash.now[:success] = "Spotify authorization successful."
      genre_response = SpotifyApiService.get_genres(access_token)
      @genres = genre_response[:data][:genres]
      @token = access_token
    else #wondering if we need this since if we can't get authorization, we won't get to the redirect
      flash[:warning] = "Spotify authorization failed. #{params[:error]}"
      redirect_to root_path
    end
  end

  def show
    # used to display the playlist to the user
    # show loading screen until playlist is sent back as response
  end

  def create
    # make service call to backend to create playlist; pass params
    if params[:genre].empty? || params[:workout].empty?
      flash[:warning] = 'Please select both Genre and Workout'
      redirect_to "/generate_playlist?tkn=#{params[:token]}"
    else
      FastracksBeService.submit_playlist(params)
      redirect_to '/playlist'
    end
  end
end
