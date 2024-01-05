require "rails_helper"

describe "Spotify API service" do
  before(:each) do
    genres = %w[acoustic afrobeat alt-rock alternative ambient anime black-metal bluegrass blues bossanova brazil breakbeat british cantopop chicago-house children chill classical club comedy country dance dancehall death-metal deep-house detroit-techno disco disney drum-and-bass dub dubstep edm electro electronic emo folk forro french funk garage german gospel goth grindcore groove grunge guitar happy hard-rock hardcore hardstyle heavy-metal hip-hop holidays honky-tonk house idm indian indie indie-pop industrial iranian j-dance j-idol j-pop j-rock jazz k-pop kids latin latino malay mandopop metal metal-misc metalcore minimal-techno movies mpb new-age new-release opera pagode party philippines-opm piano pop pop-film post-dubstep power-pop progressive-house psych-rock punk punk-rock r-n-b rainy-day reggae reggaeton road-trip rock rock-n-roll rockabilly romance sad salsa samba sertanejo show-tunes singer-songwriter ska sleep songwriter soul soundtracks spanish study summer swedish synth-pop tango techno trance trip-hop turkish work-out world-music]
    allow(SpotifyApiService).to receive(:get_genres).with("fakeToken").and_return({data: {genres: genres}})
  end

  it "retrieves an access token" do
    expected_response = {
      access_token: "BQAGo0TdA69BDesdxnX_T6QdU_968YJWOAyREwNwXvrdqGDd0Gs3JHaXJeVe5YVmli2eiMiZEJ0BCHmnI17rFWo6Fc4mT51Wom34Ic_gYK-J1FfyrqhYcqY8REMTdCyvqESA2e-hDGu5IsJ702IWcwA1EFYkFVXxLYpV-4zBFszObc1-wjtL_iIKLoo9ngH1fm4RlVObIAwNJX7QJpaaXg",
      token_type: "Bearer",
      expires_in: 3600,
      refresh_token: "AQA2NJ5n0lWJSLen7BaMp6jQbXHrdIBU60JmVVC-cLpiFJaQmtAiJ4BikAb47UVdz9yfmYYfJ8xKLnkR-MD9Nv7sO9NY2yDIf3PUXI_TvmXHhBLDUTM5kpkLmPI2PS83XFw",
      scope: "playlist-read-private playlist-read-collaborative"
    }

    allow(SpotifyApiService).to receive(:request_token).and_return({data: expected_response})

    response = SpotifyApiService.request_token("validToken")[:data]

    expect(response).to be_a Hash
  end

  it "retrieves genres" do
    response = SpotifyApiService.get_genres("fakeToken")
    expect(response).to be_a Hash
    expect(response[:data][:genres]).to be_a Array
  end
end
