require "rails_helper"

describe "Spotify API service" do
  xit "authorizes FasTracks app" do

  end

  it "retrieves an access token" do
    expected_response = {
      access_token: "BQAGo0TdA69BDesdxnX_T6QdU_968YJWOAyREwNwXvrdqGDd0Gs3JHaXJeVe5YVmli2eiMiZEJ0BCHmnI17rFWo6Fc4mT51Wom34Ic_gYK-J1FfyrqhYcqY8REMTdCyvqESA2e-hDGu5IsJ702IWcwA1EFYkFVXxLYpV-4zBFszObc1-wjtL_iIKLoo9ngH1fm4RlVObIAwNJX7QJpaaXg",
      token_type: "Bearer",
      expires_in: 3600,
      refresh_token: "AQA2NJ5n0lWJSLen7BaMp6jQbXHrdIBU60JmVVC-cLpiFJaQmtAiJ4BikAb47UVdz9yfmYYfJ8xKLnkR-MD9Nv7sO9NY2yDIf3PUXI_TvmXHhBLDUTM5kpkLmPI2PS83XFw",
      scope: "playlist-read-private playlist-read-collaborative"
    }

    allow(SpotifyApiService).to receive(:request_token).and_return(expected_response)

    response = SpotifyApiService.request_token("validToken")

    expect(response).to be_a Hash
  end

  it "retrieves genres" do
    response = SpotifyApiService.get_genres(
      "BQAMQGU7Tkb7RY06tdyO4Tqg5cP7EfdLUV0Yp7eSSU8i-SmfLHnwsiXgQ0xSIhIeqlbhKlJpVfZxbf8bOdkDP84gFwVQLgwtQjpbmF3F1aHzTPajCHcrzkAQ6WXrTake1DYpzduC0hIZyI_ASO9Ml1bliZMnqPYWTRWFYbMd18opuNZnDgBKCTtN0PH6zC0yvDyJsos4Or7l6tJ-7l2OCg")

    expect(response).to be_a Hash
    expect(response[:data][:genres]).to be_a Array
  end
end
