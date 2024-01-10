class WelcomeController < ApplicationController
  def index
    @CLIENT_ID = Rails.application.credentials.spotify[:client_id]
  end
end
