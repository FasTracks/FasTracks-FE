require 'rails_helper'

describe 'playlist poros' do
  it 'exist' do
    data = File.read('spec/support/fixtures/fastracks/playlist.json')
    json_data = JSON.parse(data, symbolize_names: true)[:data]
    music_info = Playlist.new(json_data)
    expect(music_info.name).to eq('Spotify Web API Testing playlist')
    expect(music_info.id).to eq('3cEYpjA9oz9GiPac4AsH4n')
    expect(music_info.url).to eq('https://open.spotify.com/playlist/3cEYpjA9oz9GiPac4AsH4n')
    expect(music_info.total).to eq(5)
    expect(music_info.list_of_songs_and_artist[:tracks][0][:name]).to eq('Api')
    expect(music_info.list_of_songs_and_artist[:tracks][0][:artist]).to eq('Odiseo')
    expect(music_info.list_of_songs_and_artist[:tracks][0][:image]).to eq('https://i.scdn.co/image/ab67616d00004851ce6d0eef0c1ce77e5f95bbbc')
  end
end