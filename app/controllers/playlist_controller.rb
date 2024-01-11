class PlaylistController < ApplicationController
  def generate
    # access totken passed from CallbackController callback method
    access_token = params[:tkn]
    if !access_token.nil?
      flash.now[:success] = "Spotify authorization successful."
      genre_response = SpotifyApiService.get_genres(access_token)
      @genres = genre_response[:data][:genres]
      @token = access_token
      # genre is created via API call to spotify to utilize in view page
    else 
      flash[:warning] = "Spotify authorization failed. #{params[:error]}"
      redirect_to root_path
    end
  end

  def show
    # used to display the playlist to the user, data is passed on from PlaylistController create method. Playlist PORO is used to create information used on the show page.
    data = Rails.cache.read('large_json_data')[:data]
    @playlist_info = Playlist.new(data)
    # require 'pry'; binding.pry
    @token = params[:tkn]
  end

  def create
    # playlist is not generated if genre or workout type is empty
    if params[:genre].empty? || params[:workout].empty?
      flash[:warning] = 'Please select both Genre and Workout'
      redirect_to "/generate_playlist?tkn=#{params[:token]}"
    else # make service call to backend to create playlist; caches json data from the BE service response
      response = FastracksBeService.submit_playlist(params)
      response_json = JSON.parse(response.body, symbolize_names: true)
      Rails.cache.write('large_json_data', response_json, expires_in: 1.minutes)
      # require 'pry'; binding.pry
      redirect_to playlist_path(tkn: params[:token])
    end
  end
end
