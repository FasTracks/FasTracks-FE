require "rails_helper"

RSpec.describe "Playlists#show", type: :feature do
  # As a user,
  # when I click on the button to create playlist from the generate a playlist page:
  #
  # -It redirects me to the playlist show page
  # -It shows a message that playlist has been successfully created
  # -It shows the playlist name, playlist length, song title and artist name
  # -It has a link to create another playlist

  before(:each) do
    genres = %w[acoustic afrobeat alt-rock alternative ambient anime black-metal bluegrass blues bossanova brazil breakbeat british cantopop chicago-house children chill classical club comedy country dance dancehall death-metal deep-house detroit-techno disco disney drum-and-bass dub dubstep edm electro electronic emo folk forro french funk garage german gospel goth grindcore groove grunge guitar happy hard-rock hardcore hardstyle heavy-metal hip-hop holidays honky-tonk house idm indian indie indie-pop industrial iranian j-dance j-idol j-pop j-rock jazz k-pop kids latin latino malay mandopop metal metal-misc metalcore minimal-techno movies mpb new-age new-release opera pagode party philippines-opm piano pop pop-film post-dubstep power-pop progressive-house psych-rock punk punk-rock r-n-b rainy-day reggae reggaeton road-trip rock rock-n-roll rockabilly romance sad salsa samba sertanejo show-tunes singer-songwriter ska sleep songwriter soul soundtracks spanish study summer swedish synth-pop tango techno trance trip-hop turkish work-out world-music]
    allow(SpotifyApiService).to receive(:get_genres).with("fakeToken").and_return({data: {genres: genres}})
  end

  it "After selecting a genre and workout, it brings me to the playlist show page" do
    json_response = File.read('spec/support/fixtures/fastracks/playlist.json')
    stub_request(:post, "http://localhost:3000/api/v1/playlists").
      with(
        body: "{\"token\":\"fakeToken\",\"genre\":\"pop\",\"workout\":\"Endurance\",\"playlist_name\":\"FasTracks Pop Endurance\"}",
        headers: {
      'Accept'=>'*/*',
      'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
      'Content-Type'=>'application/json',
      'User-Agent'=>'Faraday v2.9.0'
        }).
      to_return(status: 200, body: json_response, headers: {})

    visit "/generate_playlist?tkn=fakeToken"

    select "Pop", from: :genre
    select "Endurance", from: :workout

    click_button("Create My Playlist")

    expect(current_path).to eq("/playlist")
  end

  it "Displays the 'Create Another Playlist' button" do
    json_response = File.read('spec/support/fixtures/fastracks/playlist.json')
    stub_request(:post, "http://localhost:3000/api/v1/playlists").
         with(
           body: "{\"token\":\"fakeToken\",\"genre\":\"pop\",\"workout\":\"Endurance\",\"playlist_name\":\"FasTracks Pop Endurance\"}",
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type'=>'application/json',
          'User-Agent'=>'Faraday v2.9.0'
           }).
         to_return(status: 200, body: json_response, headers: {})

    visit "/generate_playlist?tkn=fakeToken"

    select "Pop", from: :genre
    select "Endurance", from: :workout

    click_button("Create My Playlist")

    expect(current_path).to eq("/playlist")
    expect(page).to have_button("Create Another Playlist")
    click_link("Create Another Playlist")
    expect(current_path).to eq("/generate_playlist")
  end

  it "Displays the playlist details (Playlist Name, Playlist Length, Song Titles, and Artist Names)" do
    json_response = File.read('spec/support/fixtures/fastracks/playlist.json')
    stub_request(:post, "http://localhost:3000/api/v1/playlists").
         with(
           body: "{\"token\":\"fakeToken\",\"genre\":\"pop\",\"workout\":\"Endurance\",\"playlist_name\":\"FasTracks Pop Endurance\"}",
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type'=>'application/json',
          'User-Agent'=>'Faraday v2.9.0'
           }).
         to_return(status: 200, body: json_response, headers: {})

    visit "/generate_playlist?tkn=fakeToken"

    select "Pop", from: :genre
    select "Endurance", from: :workout

    click_button("Create My Playlist")

    expect(current_path).to eq("/playlist")
    expect(page).to have_button("Create Another Playlist")
    expect(page).to have_selector('table')
    expect(page).to have_content('Track Name')
    expect(page).to have_content('Artist Name')
    expect(page).to have_content('Api')
    expect(page).to have_content('Odiseo')
  end

  it 'has a link that takes you to listen on spotify' do
    json_response = File.read('spec/support/fixtures/fastracks/playlist.json')
    stub_request(:post, "http://localhost:3000/api/v1/playlists").
         with(
           body: "{\"token\":\"fakeToken\",\"genre\":\"pop\",\"workout\":\"Endurance\",\"playlist_name\":\"FasTracks Pop Endurance\"}",
           headers: {
          'Accept'=>'*/*',
          'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Content-Type'=>'application/json',
          'User-Agent'=>'Faraday v2.9.0'
           }).
         to_return(status: 200, body: json_response, headers: {})

    visit "/generate_playlist?tkn=fakeToken"

    select "Pop", from: :genre
    select "Endurance", from: :workout

    click_button("Create My Playlist")
    expect(page).to have_link('Listen on Spotify', href: 'https://open.spotify.com/playlist/3cEYpjA9oz9GiPac4AsH4n')
  end
end
