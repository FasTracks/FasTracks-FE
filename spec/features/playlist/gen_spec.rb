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

    expect(page).to have_select(:workout, with_options: %w[Strength-Training Cardio HIIT Yoga Recovery])
    expect(page).to have_select(:genre, with_options: %w[Rock Pop Jazz Metal Country Electronic])
  end

  it "shows a button to create a playlist" do
    visit "/generate_playlist?tkn=fakeToken"

    expect(page).to have_button("Create My Playlist")
  end

  
end
