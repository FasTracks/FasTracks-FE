require "./config/spotify_credentials"

class SpotifyApiService

  def self.authorize
    account_connection.get("/authorize") do |req|
      req.params["client_id"] = ENV["SPOTIFY_CLIENT_ID"]
      req.params["response_type"] = "code"
      req.params["scope"] = "playlist-modify-private playlist-modify-collaborative"
      req.params["redirect_uri"] = "http://localhost:5000/callback"
    end
  end

  def self.request_token(code)
    begin
      response = account_connection.post("/api/token") do |req|
        req.headers["Authorization"] =
          "Basic #{Base64.strict_encode64("#{SPOTIFY_CLIENT_ID}:#{SPOTIFY_CLIENT_SECRET}")}"
        req.params["grant_type"] = "authorization_code"
        req.params["code"] = code
        req.params["redirect_uri"] = "http://localhost:5000/callback"
      end

      response_conversion(response)
    end
  rescue Faraday::Error => e
    # You can handle errors here (4xx/5xx responses, timeouts, etc.)
    puts e.response[:status]
    puts e.response[:body]
  end

  def self.get_user(token)
    begin
      response = conn.get("me") do |req|
        req.headers["Authorization"] = "Bearer #{token}"
      end

      response_conversion(response)
    end
  rescue Faraday::Error => e
    # You can handle errors here (4xx/5xx responses, timeouts, etc.)
    puts e.response[:status]
    puts e.response[:body]
  end

  def self.get_genres(token)
    begin
      response = conn.get("recommendations/available-genre-seeds") do |req|
        req.headers["Authorization"] = "Bearer #{token}"
      end

      response_conversion(response)
    end
  rescue Faraday::Error => e
    # You can handle errors here (4xx/5xx responses, timeouts, etc.)
    puts e.response[:status]
    puts e.response[:body]
  end

  def self.account_connection
    Faraday.new(url: "https://accounts.spotify.com/") do |conn|
      # conn.request :url_encoded
    end
  end

  def self.conn
    Faraday.new(url: "https://api.spotify.com/v1/") do |conn|
      conn.request :url_encoded
    end
  end

  def self.response_conversion(response)
    {status: response.status, data: JSON.parse(response.body, symbolize_names: true)}
  end
end
