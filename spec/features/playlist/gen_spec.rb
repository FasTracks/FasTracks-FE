require "rails_helper"

describe "playlist generation" do
  # As a visitor,
  # when I am on the create a playlist page:
  # I see the alert message that I have successfully connected to my Spotify account,
  # I see a drop down selection for genre and workout type,
  # I see a button to create a playlist
  before(:each) do
    genres = %w[acoustic afrobeat alt-rock alternative ambient anime black-metal bluegrass blues bossanova brazil breakbeat british cantopop chicago-house children chill classical club comedy country dance dancehall death-metal deep-house detroit-techno disco disney drum-and-bass dub dubstep edm electro electronic emo folk forro french funk garage german gospel goth grindcore groove grunge guitar happy hard-rock hardcore hardstyle heavy-metal hip-hop holidays honky-tonk house idm indian indie indie-pop industrial iranian j-dance j-idol j-pop j-rock jazz k-pop kids latin latino malay mandopop metal metal-misc metalcore minimal-techno movies mpb new-age new-release opera pagode party philippines-opm piano pop pop-film post-dubstep power-pop progressive-house psych-rock punk punk-rock r-n-b rainy-day reggae reggaeton road-trip rock rock-n-roll rockabilly romance sad salsa samba sertanejo show-tunes singer-songwriter ska sleep songwriter soul soundtracks spanish study summer swedish synth-pop tango techno trance trip-hop turkish work-out world-music]
    allow(SpotifyApiService).to receive(:get_genres).with("fakeToken").and_return({data: {genres: genres}})
  end

  it "shows an alert message when successfully connected to Spotify" do
    visit "/generate_playlist?tkn=fakeToken"

    expect(page).to have_content("Spotify authorization successful.")
  end

  it "shows a drop down selection for genre and workout type" do
    visit "/generate_playlist?tkn=fakeToken"

    expect(page).to have_select(:workout, with_options: %w[Strength Endurance HIIT Yoga Restore])
    expect(page).to have_select(:genre, with_options: %w[Rock Pop Jazz Metal Country Electronic])
  end

  it "shows a button to create a playlist" do
    visit "/generate_playlist?tkn=fakeToken"

    expect(page).to have_button("Create My Playlist")
  end
end

describe 'sad path' do
  it 'does not create a playlist and gives error message if genre or workout type is not selected' do
    temp_token = "BQChjA3QWZ2vOvVQMlfO86u6R1WPHXKyVw2-XXhIYCLzWoF6ig5bPnQsQzsYRzUYO2nTJP5OMCpvcYRheT9fA9XuxKwt3CwAnkfAKj3h-i10dabDg3ONpa6xuVeFYxKisMppYnS4lbyajmLoak6AtCT1zdQt3HxKSUCbT350tu8mCHIXqctu1WLGSuDqoJ5veSWiPA"

    expected_response = {
      access_token: temp_token,
      token_type: "Bearer",
      expires_in: 3600,
      refresh_token: "AQDoVhiCim3SctO10xnzGJ-o46GToLZieFicNvygpaf8yPCL5KYU-OUt46DIdS-MHLm_GH47DnitwInjZ5PBaADhmVvMGWe2N_SJuGMLrPdi1JHErikEO4qV3VRFhciB9Xk",
      scope: "playlist-read-private playlist-read-collaborative",
      genres: %w[acoustic afrobeat alt-rock alternative ambient anime black-metal bluegrass blues bossanova brazil breakbeat british cantopop chicago-house children chill classical club comedy country dance dancehall death-metal deep-house detroit-techno disco disney drum-and-bass dub dubstep edm electro electronic emo folk forro french funk garage german gospel goth grindcore groove grunge guitar happy hard-rock hardcore hardstyle heavy-metal hip-hop holidays honky-tonk house idm indian indie indie-pop industrial iranian j-dance j-idol j-pop j-rock jazz k-pop kids latin latino malay mandopop metal metal-misc metalcore minimal-techno movies mpb new-age new-release opera pagode party philippines-opm piano pop pop-film post-dubstep power-pop progressive-house psych-rock punk punk-rock r-n-b rainy-day reggae reggaeton road-trip rock rock-n-roll rockabilly romance sad salsa samba sertanejo show-tunes singer-songwriter ska sleep songwriter soul soundtracks spanish study summer swedish synth-pop tango techno trance trip-hop turkish work-out world-music]
  }.to_json

    stub_request(:get, "https://api.spotify.com/v1/recommendations/available-genre-seeds").
    with(
      headers: {
     'Accept'=>'*/*',
     'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
     'Authorization'=>"Bearer #{temp_token}",
     'User-Agent'=>'Faraday v2.8.1'
      }).
    to_return(status: 200, body: expected_response, headers: {})
    visit "/generate_playlist?tkn=#{temp_token}"
    click_button('Create My Playlist')
    
    expect(page).to have_content('Please select both Genre and Workout')
    
    expect(current_path).to eq(generate_playlist_path)
  end
end
