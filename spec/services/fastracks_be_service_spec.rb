require 'rails_helper'

describe 'FasTrackBeService' do
  it 'sends the data in JSON format to be parsed in Hash' do
    data = {
      token: "fakeToken",
      genre: "EDM",
      workout: "HIIT",
      playlist_name: 'FasTracks EDM HIIT'
    }
    json_data = data.to_json

    stub_request(:post, "http://localhost:3000/api/v1/playlists").
    with(
      body: json_data,
      headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Content-Type'=>'application/x-www-form-urlencoded',
      'User-Agent'=>'Faraday v2.8.1'
        }).
    to_return(status: 200, body: "", headers: {})

    response = FastracksBeService.submit_playlist(data)
    expect(JSON.parse(response.env.request_body)).to be_a Hash
  end


end