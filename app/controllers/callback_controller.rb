class CallbackController < ApplicationController
  def show
    access_token = params[:code]  # the auth code is passed in the URL after the user has been redirected back to the app

    if !access_token.nil?
      flash[:notice] = "Spotify authorization successful."
      genre_response = SpotifyApiService.get_genres(access_token)
      @genres = genre_response[:data][:genres]
    else
      flash[:error] = "Spotify authorization failed. #{params[:error]}"
      redirect_to root_path
    end
  end
end
