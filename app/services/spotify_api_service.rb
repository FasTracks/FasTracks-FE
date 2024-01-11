class SpotifyApiService
  # This is handled with the Spotify login redirect and not with this ApiService

  def self.request_token(code)
    begin
      response = account_connection.post("/api/token") do |req|
        req.headers["Authorization"] =
          "Basic #{Base64.strict_encode64("#{Rails.application.credentials.spotify[:client_id]}:#{Rails.application.credentials.spotify[:client_secret]}")}"
        req.params["grant_type"] = "authorization_code"
        req.params["code"] = code
        req.params["redirect_uri"] = callback_url
      end

      response_conversion(response)
    end
    rescue Faraday::Error => e 
      handle_faraday_error(e)
  end

  def self.get_user(token)
    begin
      response = conn.get("me") do |req|
        req.headers["Authorization"] = "Bearer #{token}"
      end

      response_conversion(response)
    end
    rescue Faraday::Error => e    
      handle_faraday_error(e)
  end

  def self.get_genres(token)
    begin
      response = conn.get("recommendations/available-genre-seeds") do |req|
        req.headers["Authorization"] = "Bearer #{token}"
      end

      response_conversion(response)
    end
    rescue Faraday::Error => e
      handle_faraday_error(e)
  end

  def self.account_connection
    Faraday.new(url: "https://accounts.spotify.com/") 
  end

  def self.conn
    Faraday.new(url: "https://api.spotify.com/v1/") do |conn|
      conn.request :url_encoded
    end
  end

  def self.response_conversion(response)
    {status: response.status, data: JSON.parse(response.body, symbolize_names: true)}
  end

  def self.callback_url
    Rails.application.routes.url_helpers.callback_url(host: ENV.fetch("APP_HOST"))
  end

  private

  def handle_faraday_error(exception)
    # You can handle errors here (4xx/5xx responses, timeouts, etc.)
    puts exception.response[:status]
    puts exception.response[:body]
  end
end
