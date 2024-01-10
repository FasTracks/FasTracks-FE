class CallbackController < ApplicationController
  def callback
    auth_code = params[:code] # the auth code is passed in the URL (via link in landing pag) in after the user has been redirected back to the app
    # auth code needs to be exchanged for an access token
    access_token = SpotifyApiService.request_token(auth_code)[:data][:access_token]
    redirect_to "/generate_playlist?tkn=#{access_token}"
  end
end
