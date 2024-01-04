require './config/spotify_credentials'

class WelcomeController < ApplicationController
  def index
    @CLIENT_ID = CLIENT_ID
  end
end
