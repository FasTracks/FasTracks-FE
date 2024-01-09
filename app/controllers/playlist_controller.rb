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
    # json_response = session[:data]
    temp_file_path = params[:temp_file_path]
    data = JSON.parse(File.read(temp_file_path), symbolize_names: true)[:data]
    @token = params[:token]
    @playlist_info = Playlist.new(data)
  end

  def create
    # make service call to backend to create playlist; pass params
    if params[:genre].empty? || params[:workout].empty?
      flash[:warning] = 'Please select both Genre and Workout'
      redirect_to "/generate_playlist?tkn=#{params[:token]}"
    else
      response = FastracksBeService.submit_playlist(params)
      body = response.body
      temp_file_path = Rails.root.join('tmp', 'body')
      File.write(temp_file_path, body)
      redirect_to playlist_path(temp_file_path: temp_file_path, token: params[:token])

      #this is where we receive the data, need to figure out how to pass this response to the playlist show view
    end
  end
end
