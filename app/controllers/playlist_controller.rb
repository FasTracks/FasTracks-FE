class PlaylistController < ApplicationController
  def generate
    access_token = params[:tkn]
    if !access_token.nil?
      flash.now[:success] = "Spotify authorization successful."
      genre_response = SpotifyApiService.get_genres(access_token)
      @genres = genre_response[:data][:genres]
      @token = access_token
    else 
      flash[:warning] = "Spotify authorization failed. #{params[:error]}"
      redirect_to root_path
    end
  end

  def show
    # used to display the playlist to the user
    # show loading screen until playlist is sent back as response
    data = Rails.cache.read('large_json_data')[:data]
    @playlist_info = Playlist.new(data)
    @token = params[:tkn]
    # Rails.cache.delete('large_json_data')
  end

  def create
    if params[:genre].empty? || params[:workout].empty?
      flash[:warning] = 'Please select both Genre and Workout'
      redirect_to "/generate_playlist?tkn=#{params[:token]}"
    else # make service call to backend to create playlist; pass params
      response = FastracksBeService.submit_playlist(params)
      response_json = JSON.parse(response.body, symbolize_names: true)
      Rails.cache.write('large_json_data', response_json, expires_in: 1.minutes)
      redirect_to playlist_path(tkn: params[:token])
    end
  end
end
