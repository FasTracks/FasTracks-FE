module FastracksBeService
  def self.submit_playlist(params)
    data = {
      token: params[:token],
      genre: params[:genre],
      workout: params[:workout],
      playlist_name: "FasTracks #{params[:genre]} #{params[:workout]}"
    }

    json_data = data.to_json
    conn.post("/api/v1/playlists") do |req|
      req.body = json_data
      req.headers["Content-Type"] = "application/json"
    end
  end

  def self.conn
    Faraday.new(url: url) do |faraday|
      faraday.request :url_encoded
    end
  end

  def self.url
    ENV["BACKEND_SERVICE_ENDPOINT"]
  end
end
