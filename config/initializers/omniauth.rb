require "./config/spotify_credentials"

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, CLIENT_ID, CLIENT_SECRET, scope: %w(
    playlist-read-private
    user-read-private
    user-read-email
  ).join(' ')
end