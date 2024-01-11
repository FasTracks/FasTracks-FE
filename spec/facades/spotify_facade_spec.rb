require 'rails_helper'

describe 'spotify facade' do
  it 'exist' do

    response_body = "{\"access_token\":\"fake_token\",\"token_type\":\"Bearer\",\"expires_in\":3600,\"refresh_token\":\"refresh_token\",\"scope\":\"playlist-read-private playlist-read-collaborative\"}"

    stub_request(:post, "https://accounts.spotify.com/api/token?code=fake_code&grant_type=authorization_code&redirect_uri=http://localhost:5000/callback").
      with(
        headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Authorization'=>"Basic #{Rails.application.credentials.spotify[:authorization]}",
      'Content-Length'=>'0',
      'User-Agent'=>'Faraday v2.9.0'
        }).
    to_return(status: 200, body: response_body, headers: {})

    service = SpotifyFacade.access_token('fake_code')
    expect(service).to eq('fake_token')
  end
end