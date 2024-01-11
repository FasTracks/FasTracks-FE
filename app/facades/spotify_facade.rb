class SpotifyFacade
  def self.access_token(code)
    SpotifyApiService.request_token(code)[:data][:access_token]
  end

  def self.get_genre(access_token)
    SpotifyApiService.get_genres(access_token)[:data][:genres]
  end
end