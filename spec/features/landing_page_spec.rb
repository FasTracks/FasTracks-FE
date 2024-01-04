require 'rails_helper'

describe 'Landing Page' do
  #US 1
  it 'has a button that requests Spotify access' do
    visit root_path

    expect(page).to have_button('Connect to Spotify to Create a Playlist')
  end

  it 'takes you to sign into your Spotify account when you click the button' do
    click_button('Connect to Spotify to Create a Playlist')
  end

  it 'redirects you to create a playlist page when you sign in' do
    
  end
end


# -As a visitor, when I visit the landing page, I see a button to Connect to Spotify to Create a Playlist
# -When you click on the button, it takes you to sign into your Spotify account
# -Once you sign in, it redirects you to create a playlist page