require 'rails_helper'

describe 'FasTrackBeService' do
  it 'sends the data in JSON format' do
    stub_request(:post, "http://localhost:3000/api/v1/playlists").
        with(
          body: {"{\"token\":\"fakeToken\",\"genre\":\"EDM\",\"workout\":\"HIIT\"}"=>nil},
          headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type'=>'application/x-www-form-urlencoded',
          'User-Agent'=>'Faraday v2.8.1'
          }).
        to_return(status: 200, body: "", headers: {})
    
    data = {
      token: "fakeToken",
      genre: "EDM",
      workout: "HIIT"
    }
    request = FastracksBeService.submit_playlist(data)

    require 'pry'; binding.pry
    expect(request[:body]).to be_a JSON
  end
end