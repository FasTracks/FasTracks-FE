class CallbackController < ApplicationController
  def show
    @auth_code = params[:code]
  end
end
