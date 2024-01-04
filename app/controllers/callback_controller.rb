class CallbackController < ApplicationController
  def show
    auth_code = params[:code]  # the auth code is passed in the URL after the user has been redirected back to the app

    if !auth_code.nil?
      flash[:notice] = "Spotify authorization successful."
      @genres = nil  # make api call and cache to @genres, filter here as well.
    else
      flash[:error] = "Spotify authorization failed. #{params[:error]}"
      redirect_to root_path
    end
  end
end
