class FastracksBeService
  def self.submit_playlist(params)
    conn.post("/api/v1/playlists") do |req|
      req.params["token"] = params[:token]
      req.params["genre"] = params[:genre]
      req.params["workout"] = params[:workout]
    end
  end

  def self.conn
    Faraday.new(url: "http://localhost:3000/") do |faraday|
      faraday.request :url_encoded
    end
  end
end
