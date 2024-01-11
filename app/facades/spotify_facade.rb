class SpotifyFacade
  def self.access_token(code)
    SpotifyApiService.request_token(code)[:data][:access_token]
  end
end