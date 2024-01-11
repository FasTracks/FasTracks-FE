require 'rails_helper'

describe 'FastracksBeServiceFacade' do
  it 'exist' do
    json = File.read('spec/support/fixtures/fastracks/playlist.json')
    data = {
      token: "fakeToken",
      genre: "EDM",
      workout: "HIIT",
      playlist_name: 'FasTracks EDM HIIT'
    }
    stub_request(:post, "http://localhost:3000/api/v1/playlists").
        with(
          body: "{\"token\":\"fakeToken\",\"genre\":\"edm\",\"workout\":\"HIIT\",\"playlist_name\":\"FasTracks EDM HIIT\"}",
          headers: {
        'Accept'=>'*/*',
        'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
        'Content-Type'=>'application/json',
        'User-Agent'=>'Faraday v2.9.0'
          }).
        to_return(status: 200, body: json, headers: {})
    response = FastracksBeServiceFacade.submit_playlist(data)

    expect(response).to be_a Hash
    expect(response).to have_key(:status)
    expect(response).to have_key(:data)
  end
end