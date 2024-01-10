require "rails_helper"

RSpec.describe "landing page" do
  describe "Landing Page" do
    # US 1
    # -As a visitor, when I visit the landing page, I see a button to Connect to Spotify to Create a Playlist
    # -When you click on the button, it takes you to sign into your Spotify account
    # -Once you sign in, it redirects you to create a playlist page

    it "has a app name and a button that requests Spotify access" do
      visit root_path

      expect(page).to have_content("FasTracks")
      expect(page).to have_button("Connect to Spotify to Create a Playlist")
    end

    it "has a button for Spotify Authorization and Close when you click on Connect to Spotify to Create a Playlist" do
      visit root_path

      click_button("Connect to Spotify to Create a Playlist")

      within(".modal") do
        expect(page).to have_content("Spotify Authorization")
        expect(page).to have_content("Connect your Spotify account to access more features.")
        expected_href = "https://accounts.spotify.com/authorize?client_id=#{Rails.application.credentials.spotify[:client_id]}&response_type=code&redirect_uri=http://www.example.com/callback&scope=playlist-modify-private%20playlist-modify-public"
        expect(page).to have_link("Authorize on Spotify", href: expected_href)
        expect(page).to have_button("Close")
      end
    end
  end
end
