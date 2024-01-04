require "rails_helper"

describe "playlist generation" do
  # As a visitor,
  # when I am on the create a playlist page:
  # I see the alert message that I have successfully connected to my Spotify account,
  # I see a drop down selection for genre and workout type,
  # I see a button to create a playlist
  it "shows an alert message when successfully connected to Spotify" do
    visit "/callback?code=fakeAuthCode"

    expect(page).to have_content("Spotify authorization successful.")
  end

  it "makes an api call to Spotify to get a list of genres" do
    visit "/callback?code=fakeAuthCode"
  end

  it "shows a drop down selection for genre and workout type" do
    visit "/callback?code=fakeAuthCode"

    expect(page).to have_select("workout", with_options: %w[Strength-Training Cardio HIIT Yoga Recovery])
    expect(page).to have_select("genre", with_options: %w[Rock Pop Jazz Metal Hip-Hop Country R&B Electronic Folk Classical Indie Other])
  end

  it "shows a button to create a playlist" do
    visit callback_path

    expect(page).to have_button("Generate Me a Playlist")
  end
end
