require 'rails_helper'

describe 'FasTrackBeService' do
  it 'sends the data in JSON format' do
    data = {
      token: "fakeToken",
      genre: "EDM",
      workout: "HIIT",
      playlist_name: 'FasTracks EDM HIIT'
    }
    # stub_request(:post, "http://localhost:3000/api/v1/playlists").
    #     with(
    #       body: data.to_json,
    #       headers: {
    #       'Accept'=>'*/*',
    #       'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
    #       'Content-Type'=>'application/x-www-form-urlencoded',
    #       'User-Agent'=>'Faraday v2.8.1'
    #       }).
    #     to_return(status: 200, body: "", headers: {})

    stub_request(:get, "http://localhost:3000/api/v1/playlists").
         with(
           body: data.to_json,
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type'=>'application/x-www-form-urlencoded',
          'User-Agent'=>'Faraday v2.8.1'
           }).
         to_return(status: 200, body: "", headers: {})

    request = FastracksBeService.submit_playlist(data)

    expect(request.env.request_body).to be_a JSON
  end
end