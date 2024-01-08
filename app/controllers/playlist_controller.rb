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
    json_response = params[:playlist_info]
    @playlist_info = Playlist.new(json_response)
  end

  def create
    # make service call to backend to create playlist; pass params
    if params[:genre].empty? || params[:workout].empty?
      flash[:warning] = 'Please select both Genre and Workout'
      redirect_to "/generate_playlist?tkn=#{params[:token]}"
    else
      response = FastracksBeService.submit_playlist(params)
      playlist_info = JSON.parse(response.body, symbolize_names: true)
      
      redirect_to playlist_path(playlist_info: playlist_info)
      
      #this is where we receive the data, need to figure out how to pass this response to the playlist show view
    end
  end
end
