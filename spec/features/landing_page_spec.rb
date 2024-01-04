require 'rails_helper'

describe 'Landing Page' do
  #US 1
  it 'has a app name and a button that requests Spotify access' do
    visit root_path

    expect(page).to have_content('FasTracks')
    expect(page).to have_button('Connect to Spotify to Create a Playlist')
  end

  it 'takes you to sign into your Spotify account when you click the button' do
    visit root_path
    click_button('Connect to Spotify to Create a Playlist')

    within('#spotifyModal', wait: 10) do
      expect(page).to have_content('Spotify Authorization')
      expect(page).to have_content('Connect to your Spotify account to access more features.')
      expect(page).to have_button('Authorize on Spotify', visible: true)
      expect(page).to have_button('Close', visible: true)
    end
  end

  it 'redirects you to create a playlist page when you sign in' do
    
  end
end


# -As a visitor, when I visit the landing page, I see a button to Connect to Spotify to Create a Playlist
# -When you click on the button, it takes you to sign into your Spotify account
# -Once you sign in, it redirects you to create a playlist page